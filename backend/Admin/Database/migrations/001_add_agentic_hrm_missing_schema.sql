-- Migration: Bo sung schema con thieu cho HRM Agentic AI
-- Cach dung: chay file nay tren database HRM hien tai trong MySQL Workbench.
-- Luu y: file nay khong tao database moi, no su dung schema dang duoc chon.

-- =========================================================
-- 1. Bo sung lien ket chuc vu -> phong ban
-- =========================================================

ALTER TABLE positions
ADD COLUMN department_id INT NULL;

CREATE INDEX idx_positions_department_id
ON positions (department_id);

ALTER TABLE positions
ADD CONSTRAINT fk_positions_department
FOREIGN KEY (department_id)
REFERENCES departments(department_id)
ON UPDATE CASCADE
ON DELETE SET NULL;

-- =========================================================
-- 2. Bo sung rang buoc du lieu nhan vien
-- =========================================================

CREATE UNIQUE INDEX uq_employees_email
ON employees (email);

CREATE UNIQUE INDEX uq_employees_cccd
ON employees (cccd);

CREATE INDEX idx_employees_department_id
ON employees (department_id);

CREATE INDEX idx_employees_position_id
ON employees (position_id);

-- =========================================================
-- 3. Task Manager giao cho nhan vien
-- =========================================================

CREATE TABLE IF NOT EXISTS tasks (
    task_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    manager_id INT NOT NULL,
    department_id INT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT NULL,
    deadline DATETIME NOT NULL,
    priority VARCHAR(20) NOT NULL DEFAULT 'MEDIUM',
    status VARCHAR(30) NOT NULL DEFAULT 'NEW',
    progress_percent INT NOT NULL DEFAULT 0,
    expected_score DECIMAL(5,2) NOT NULL DEFAULT 100.00,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_tasks_employee
        FOREIGN KEY (employee_id)
        REFERENCES employees(employee_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_tasks_manager
        FOREIGN KEY (manager_id)
        REFERENCES employees(employee_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_tasks_department
        FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL,

    CONSTRAINT chk_tasks_progress_percent
        CHECK (progress_percent >= 0 AND progress_percent <= 100),

    CONSTRAINT chk_tasks_expected_score
        CHECK (expected_score >= 0 AND expected_score <= 100),

    CONSTRAINT chk_tasks_priority
        CHECK (priority IN ('LOW', 'MEDIUM', 'HIGH', 'CRITICAL')),

    CONSTRAINT chk_tasks_status
        CHECK (status IN (
            'NEW',
            'IN_PROGRESS',
            'SUBMITTED',
            'APPROVED',
            'REJECTED',
            'REVISION_REQUIRED',
            'OVERDUE'
        ))
);

CREATE INDEX idx_tasks_employee_id
ON tasks (employee_id);

CREATE INDEX idx_tasks_manager_id
ON tasks (manager_id);

CREATE INDEX idx_tasks_department_id
ON tasks (department_id);

CREATE INDEX idx_tasks_status
ON tasks (status);

CREATE INDEX idx_tasks_deadline
ON tasks (deadline);

-- =========================================================
-- 4. Lich su nhan vien cap nhat tien do task
-- =========================================================

CREATE TABLE IF NOT EXISTS task_progress_logs (
    progress_id INT AUTO_INCREMENT PRIMARY KEY,
    task_id INT NOT NULL,
    employee_id INT NOT NULL,
    progress_percent INT NOT NULL,
    note TEXT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_task_progress_logs_task
        FOREIGN KEY (task_id)
        REFERENCES tasks(task_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_task_progress_logs_employee
        FOREIGN KEY (employee_id)
        REFERENCES employees(employee_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT chk_task_progress_logs_percent
        CHECK (progress_percent >= 0 AND progress_percent <= 100)
);

CREATE INDEX idx_task_progress_logs_task_id
ON task_progress_logs (task_id);

CREATE INDEX idx_task_progress_logs_employee_id
ON task_progress_logs (employee_id);

-- =========================================================
-- 5. Manager review task
-- =========================================================

CREATE TABLE IF NOT EXISTS task_reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    task_id INT NOT NULL,
    manager_id INT NOT NULL,
    quality_score DECIMAL(5,2) NOT NULL DEFAULT 0.00,
    deadline_score DECIMAL(5,2) NOT NULL DEFAULT 0.00,
    decision VARCHAR(30) NOT NULL,
    comment TEXT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_task_reviews_task
        FOREIGN KEY (task_id)
        REFERENCES tasks(task_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_task_reviews_manager
        FOREIGN KEY (manager_id)
        REFERENCES employees(employee_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT chk_task_reviews_quality_score
        CHECK (quality_score >= 0 AND quality_score <= 100),

    CONSTRAINT chk_task_reviews_deadline_score
        CHECK (deadline_score >= 0 AND deadline_score <= 100),

    CONSTRAINT chk_task_reviews_decision
        CHECK (decision IN ('APPROVED', 'REJECTED', 'REVISION_REQUIRED'))
);

CREATE INDEX idx_task_reviews_task_id
ON task_reviews (task_id);

CREATE INDEX idx_task_reviews_manager_id
ON task_reviews (manager_id);

-- =========================================================
-- 6. Ket qua Agentic AI danh gia nang luc
-- =========================================================

CREATE TABLE IF NOT EXISTS competency_reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    manager_id INT NULL,
    department_id INT NULL,
    review_month INT NOT NULL,
    review_year INT NOT NULL,
    attendance_score DECIMAL(5,2) NOT NULL DEFAULT 0.00,
    task_performance_score DECIMAL(5,2) NOT NULL DEFAULT 0.00,
    quality_skill_score DECIMAL(5,2) NOT NULL DEFAULT 0.00,
    discipline_responsibility_score DECIMAL(5,2) NOT NULL DEFAULT 0.00,
    total_score DECIMAL(5,2) NOT NULL DEFAULT 0.00,
    rating VARCHAR(50) NOT NULL,
    ai_summary TEXT NULL,
    ai_recommendation TEXT NULL,
    manager_note TEXT NULL,
    status VARCHAR(30) NOT NULL DEFAULT 'DRAFT',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_competency_reviews_employee
        FOREIGN KEY (employee_id)
        REFERENCES employees(employee_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_competency_reviews_manager
        FOREIGN KEY (manager_id)
        REFERENCES employees(employee_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL,

    CONSTRAINT fk_competency_reviews_department
        FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL,

    CONSTRAINT uq_competency_reviews_employee_period
        UNIQUE (employee_id, review_month, review_year),

    CONSTRAINT chk_competency_reviews_month
        CHECK (review_month >= 1 AND review_month <= 12),

    CONSTRAINT chk_competency_reviews_year
        CHECK (review_year >= 2000),

    CONSTRAINT chk_competency_reviews_attendance_score
        CHECK (attendance_score >= 0 AND attendance_score <= 100),

    CONSTRAINT chk_competency_reviews_task_performance_score
        CHECK (task_performance_score >= 0 AND task_performance_score <= 100),

    CONSTRAINT chk_competency_reviews_quality_skill_score
        CHECK (quality_skill_score >= 0 AND quality_skill_score <= 100),

    CONSTRAINT chk_competency_reviews_discipline_score
        CHECK (discipline_responsibility_score >= 0 AND discipline_responsibility_score <= 100),

    CONSTRAINT chk_competency_reviews_total_score
        CHECK (total_score >= 0 AND total_score <= 100),

    CONSTRAINT chk_competency_reviews_status
        CHECK (status IN ('DRAFT', 'PENDING_APPROVAL', 'APPROVED', 'REJECTED'))
);

CREATE INDEX idx_competency_reviews_employee_id
ON competency_reviews (employee_id);

CREATE INDEX idx_competency_reviews_manager_id
ON competency_reviews (manager_id);

CREATE INDEX idx_competency_reviews_department_id
ON competency_reviews (department_id);

CREATE INDEX idx_competency_reviews_period
ON competency_reviews (review_year, review_month);

-- =========================================================
-- 7. Yeu cau bo sung/chinh sua cham cong
-- =========================================================

CREATE TABLE IF NOT EXISTS attendance_requests (
    request_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    work_date DATE NOT NULL,
    request_type VARCHAR(30) NOT NULL,
    requested_check_in DATETIME NULL,
    requested_check_out DATETIME NULL,
    original_check_in DATETIME NULL,
    original_check_out DATETIME NULL,
    reason TEXT NOT NULL,
    status VARCHAR(30) NOT NULL DEFAULT 'PENDING',
    reviewed_by INT NULL,
    review_note TEXT NULL,
    submitted_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    reviewed_at DATETIME NULL,

    CONSTRAINT fk_attendance_requests_employee
        FOREIGN KEY (employee_id)
        REFERENCES employees(employee_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_attendance_requests_reviewer
        FOREIGN KEY (reviewed_by)
        REFERENCES employees(employee_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL,

    CONSTRAINT chk_attendance_requests_type
        CHECK (request_type IN ('SUPPLEMENT', 'ADJUSTMENT')),

    CONSTRAINT chk_attendance_requests_status
        CHECK (status IN ('PENDING', 'APPROVED', 'REJECTED'))
);

CREATE INDEX idx_attendance_requests_employee_id
ON attendance_requests (employee_id);

CREATE INDEX idx_attendance_requests_work_date
ON attendance_requests (work_date);

CREATE INDEX idx_attendance_requests_status
ON attendance_requests (status);

-- =========================================================
-- 8. So du phep nam cua nhan vien
-- =========================================================

CREATE TABLE IF NOT EXISTS leave_balances (
    balance_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    leave_type_id INT NOT NULL,
    balance_year INT NOT NULL,
    total_days DECIMAL(5,2) NOT NULL DEFAULT 0.00,
    used_days DECIMAL(5,2) NOT NULL DEFAULT 0.00,
    remaining_days DECIMAL(5,2) NOT NULL DEFAULT 0.00,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_leave_balances_employee
        FOREIGN KEY (employee_id)
        REFERENCES employees(employee_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_leave_balances_leave_type
        FOREIGN KEY (leave_type_id)
        REFERENCES leave_types(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT uq_leave_balances_employee_type_year
        UNIQUE (employee_id, leave_type_id, balance_year),

    CONSTRAINT chk_leave_balances_year
        CHECK (balance_year >= 2000),

    CONSTRAINT chk_leave_balances_total_days
        CHECK (total_days >= 0),

    CONSTRAINT chk_leave_balances_used_days
        CHECK (used_days >= 0),

    CONSTRAINT chk_leave_balances_remaining_days
        CHECK (remaining_days >= 0)
);

CREATE INDEX idx_leave_balances_employee_id
ON leave_balances (employee_id);

CREATE INDEX idx_leave_balances_year
ON leave_balances (balance_year);

-- =========================================================
-- 9. Bo sung chi tiet bang luong neu giu UI luong hien tai
-- =========================================================

ALTER TABLE payroll
ADD COLUMN meal_allowance DECIMAL(15,2) NOT NULL DEFAULT 0.00,
ADD COLUMN transport_allowance DECIMAL(15,2) NOT NULL DEFAULT 0.00,
ADD COLUMN phone_allowance DECIMAL(15,2) NOT NULL DEFAULT 0.00,
ADD COLUMN housing_allowance DECIMAL(15,2) NOT NULL DEFAULT 0.00,
ADD COLUMN standard_days INT NOT NULL DEFAULT 22,
ADD COLUMN work_days INT NOT NULL DEFAULT 0,
ADD COLUMN overtime_hours DECIMAL(8,2) NOT NULL DEFAULT 0.00,
ADD COLUMN overtime_rate DECIMAL(5,2) NOT NULL DEFAULT 1.50,
ADD COLUMN overtime_pay DECIMAL(15,2) NOT NULL DEFAULT 0.00,
ADD COLUMN kpi_bonus DECIMAL(15,2) NOT NULL DEFAULT 0.00,
ADD COLUMN project_bonus DECIMAL(15,2) NOT NULL DEFAULT 0.00,
ADD COLUMN holiday_bonus DECIMAL(15,2) NOT NULL DEFAULT 0.00,
ADD COLUMN social_insurance DECIMAL(15,2) NOT NULL DEFAULT 0.00,
ADD COLUMN health_insurance DECIMAL(15,2) NOT NULL DEFAULT 0.00,
ADD COLUMN unemployment_insurance DECIMAL(15,2) NOT NULL DEFAULT 0.00,
ADD COLUMN personal_income_tax DECIMAL(15,2) NOT NULL DEFAULT 0.00,
ADD COLUMN advance_payment DECIMAL(15,2) NOT NULL DEFAULT 0.00,
ADD COLUMN penalties DECIMAL(15,2) NOT NULL DEFAULT 0.00,
ADD COLUMN salary_deduction DECIMAL(15,2) NOT NULL DEFAULT 0.00,
ADD COLUMN calculated_at DATETIME NULL,
ADD COLUMN approved_at DATETIME NULL,
ADD COLUMN paid_at DATETIME NULL;

CREATE INDEX idx_payroll_employee_id
ON payroll (employee_id);

CREATE INDEX idx_payroll_period
ON payroll (year, month);

CREATE INDEX idx_payroll_status
ON payroll (status);

-- =========================================================
-- 10. Thong bao trong he thong
-- =========================================================

CREATE TABLE IF NOT EXISTS notifications (
    notification_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    message TEXT NOT NULL,
    notification_type VARCHAR(50) NOT NULL,
    related_entity_type VARCHAR(50) NULL,
    related_entity_id INT NULL,
    is_read BOOLEAN NOT NULL DEFAULT FALSE,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    read_at DATETIME NULL,

    CONSTRAINT fk_notifications_employee
        FOREIGN KEY (employee_id)
        REFERENCES employees(employee_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT chk_notifications_type
        CHECK (notification_type IN (
            'TASK_ASSIGNED',
            'TASK_REVIEWED',
            'LEAVE_APPROVED',
            'LEAVE_REJECTED',
            'SALARY_READY',
            'COMPETENCY_REVIEW',
            'SYSTEM'
        ))
);

CREATE INDEX idx_notifications_employee_id
ON notifications (employee_id);

CREATE INDEX idx_notifications_is_read
ON notifications (is_read);

CREATE INDEX idx_notifications_created_at
ON notifications (created_at);

-- =========================================================
-- 11. Luu lich su chatbot vao MySQL
-- =========================================================

CREATE TABLE IF NOT EXISTS chat_sessions (
    session_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_chat_sessions_user
        FOREIGN KEY (user_id)
        REFERENCES employees(employee_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE INDEX idx_chat_sessions_user_id
ON chat_sessions (user_id);

CREATE TABLE IF NOT EXISTS chat_history (
    message_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    session_id INT NOT NULL,
    sender VARCHAR(20) NOT NULL,
    message TEXT NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_chat_history_session
        FOREIGN KEY (session_id)
        REFERENCES chat_sessions(session_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT chk_chat_history_sender
        CHECK (sender IN ('user', 'assistant', 'bot'))
);

CREATE INDEX idx_chat_history_session_id
ON chat_history (session_id);

-- =========================================================
-- 12. Luu lich su bao cao neu can lam report that
-- =========================================================

CREATE TABLE IF NOT EXISTS reports (
    report_id INT AUTO_INCREMENT PRIMARY KEY,
    report_name VARCHAR(255) NOT NULL,
    report_type VARCHAR(50) NOT NULL,
    file_type VARCHAR(20) NOT NULL,
    file_path VARCHAR(500) NULL,
    status VARCHAR(30) NOT NULL DEFAULT 'PROCESSING',
    created_by INT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_reports_created_by
        FOREIGN KEY (created_by)
        REFERENCES employees(employee_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL,

    CONSTRAINT chk_reports_file_type
        CHECK (file_type IN ('PDF', 'EXCEL', 'CSV')),

    CONSTRAINT chk_reports_status
        CHECK (status IN ('PROCESSING', 'READY', 'FAILED'))
);

CREATE INDEX idx_reports_created_by
ON reports (created_by);

CREATE INDEX idx_reports_status
ON reports (status);
