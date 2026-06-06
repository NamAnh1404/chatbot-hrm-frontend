'use client';

import { useRouter } from 'next/navigation';
import { Login } from '@/app/components/Login';

export default function LoginPage() {
  const router = useRouter();

  return <Login onLogin={() => router.push('/')} />;
}
