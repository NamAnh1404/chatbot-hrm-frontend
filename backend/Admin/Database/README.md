# Database migrations

Thu muc nay chua cac file SQL can chay tren MySQL de dong bo database voi code HRM.

## Thu tu chay

Chay theo dung thu tu ten file:

```text
backend/Admin/Database/migrations/001_add_agentic_hrm_missing_schema.sql
```

## Cach chay trong MySQL Workbench

1. Mo MySQL Workbench.
2. Chon dung schema dang dung cho project HRM, vi du `chatbot_hrm`.
3. Mo file SQL migration.
4. Chay tung file theo thu tu.
5. Sau khi chay xong, refresh schema va kiem tra cac bang moi.

## Kiem tra truoc khi chay

Truoc khi tao unique index, nen kiem tra email/CCCD co bi trung khong:

```sql
SELECT email, COUNT(*) AS total
FROM employees
GROUP BY email
HAVING COUNT(*) > 1;

SELECT cccd, COUNT(*) AS total
FROM employees
WHERE cccd IS NOT NULL AND TRIM(cccd) <> ''
GROUP BY cccd
HAVING COUNT(*) > 1;
```

Neu co du lieu trung, can sua trong MySQL truoc khi chay migration.

## Luu y

- File migration nay nen chay mot lan.
- Neu MySQL bao loi cot/bang/index da ton tai, nghia la ban da them truoc do. Khi do can bo qua lenh da co hoac tao file migration moi.
- Khong sua database bang tay roi quen cap nhat SQL trong thu muc nay.
- Khong dua mat khau MySQL vao file SQL hoac commit len GitHub.
