import { ReactNode } from 'react';

interface LoadingSpinnerProps {
  size?: 'small' | 'medium' | 'large';
  text?: string;
}

export const LoadingSpinner = ({ size = 'medium', text }: LoadingSpinnerProps) => {
  const sizeClasses = {
    small: 'w-4 h-4 border-2',
    medium: 'w-8 h-8 border-3',
    large: 'w-12 h-12 border-4',
  };

  return (
    <div className="loading-container">
      <div className={`spinner ${sizeClasses[size]}`} />
      {text && <p className="loading-text">{text}</p>}
    </div>
  );
};

interface LoadingOverlayProps {
  isLoading: boolean;
  children: ReactNode;
  text?: string;
}

export const LoadingOverlay = ({ isLoading, children, text }: LoadingOverlayProps) => {
  if (!isLoading) return <>{children}</>;

  return (
    <div className="relative">
      <div className="loading-overlay">
        <LoadingSpinner size="large" text={text} />
      </div>
      <div className="loading-content">{children}</div>
    </div>
  );
};

interface ButtonProps extends React.ButtonHTMLAttributes<HTMLButtonElement> {
  isLoading?: boolean;
  variant?: 'primary' | 'secondary' | 'danger';
  children: ReactNode;
}

export const Button = ({
  isLoading,
  variant = 'primary',
  children,
  disabled,
  ...props
}: ButtonProps) => {
  return (
    <button
      className={`btn btn-${variant}`}
      disabled={disabled || isLoading}
      {...props}
    >
      {isLoading ? (
        <>
          <LoadingSpinner size="small" />
          <span className="ml-2">Loading...</span>
        </>
      ) : (
        children
      )}
    </button>
  );
};
