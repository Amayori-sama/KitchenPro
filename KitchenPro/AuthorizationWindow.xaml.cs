using System.Linq;
using System.Windows;

namespace KitchenPro
{
    public partial class AuthorizationWindow : Window
    {
        public AuthorizationWindow()
        {
            InitializeComponent();
        }
        public int errorPass = 0;
        private void AuthCommit(object sender, RoutedEventArgs e)
        {
            Base.User user = SourceCore.db.User.SingleOrDefault(U => U.UserLogin == LoginText.Text && U.UserPassword == PasswordText.Text);
            if (user != null)
            { 
                if (errorPass == 1)
                {
                    CaptchaWindow window = new CaptchaWindow();
                    window.ShowDialog();
                    errorPass = window.errorpsw;
                }
                else
                {
                    MainWindow.user = user;
                    MainWindow wnd = new MainWindow();
                    Close();
                    wnd.ShowDialog();
                }
            }
            else
            {
                MessageBox.Show("Неверно указан логин и/или пароль!", "Предупреждение", MessageBoxButton.OK, MessageBoxImage.Warning);
                errorPass = 1;
            };
        }
        public static Base.User user;
        private void GuestCommit(object sender, RoutedEventArgs e)
        {
            MainWindow window = new MainWindow();
            window.userName.Text = "Гость";
            Close();            
            window.ShowDialog();
        }
    }
}