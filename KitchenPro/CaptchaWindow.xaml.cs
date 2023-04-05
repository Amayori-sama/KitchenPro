using System;
using System.Windows;

namespace KitchenPro
{
    public partial class CaptchaWindow : Window
    {
        public string CaptchaValue { get; set; }
        public event EventHandler CaptchaRefreshed;
        public int errorpsw;
        public CaptchaWindow()
        {
            InitializeComponent();
            CreateCaptcha();
        }
        private void ResetCaptcha(object sender, RoutedEventArgs e) => CreateCaptcha();
        private void CreateCaptcha()
        {
            string allowchar = "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z";
            allowchar += "a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,y,z";
            allowchar += "1,2,3,4,5,6,7,8,9,0";
            char[] a = { ',' };
            string[] ar = allowchar.Split(a);
            string pwd = string.Empty;
            Random r = new Random();
            for (int i = 0; i < 6; i++)
            {
                pwd += ar[r.Next(0, ar.Length)];
            }
            CaptchaText.Content = pwd;
            CaptchaValue = (string)CaptchaText.Content;
            CaptchaRefreshed?.Invoke(this, EventArgs.Empty);
        }
        private void ConfirmCpt(object sender, RoutedEventArgs e)
        { 
            if (CaptchaTextBox.Text == (string) CaptchaText.Content)
            {
                MessageBox.Show("Ok");
                errorpsw = 0;
                Close();
            }
            else
            {
                MessageBox.Show("Неверно указана капча!", "Предупреждение", MessageBoxButton.OK, MessageBoxImage.Warning);
                CaptchaTextBox.Text = "";
                CreateCaptcha();
            }
        }
    }
}