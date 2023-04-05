using System;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;

namespace KitchenPro
{
    public partial class MainWindow : Window
    {
        public static Base.User user = null;
        public MainWindow()
        {
            InitializeComponent();
            if (user != null)
            {
                userSurName.Text = user.UserSurname;
                userName.Text = user.UserName;
                userPatronymic.Text = user.UserPatronymic;
                if (user.UserRole == 1)
                {
                    allUsers.Visibility = Visibility.Visible;
                    allRoles.Visibility = Visibility.Visible;
                    allProducts.Visibility = Visibility.Visible;
                    allPoints.Visibility = Visibility.Visible;
                    allOrdProd.Visibility = Visibility.Visible;
                    allOrders.Visibility = Visibility.Visible;
                }
            }
            if (user == null)
            {
                logInOut.Content = "Войти";
            }
            else
            {
                logInOut.Content = "Выход";
            }

        }

        private void LogInOutUser(object sender, RoutedEventArgs e)
        {
            AuthorizationWindow auth = new AuthorizationWindow();
            Close();
            user = null;
            auth.ShowDialog();
        }
        private void openUsersPage(object sender, RoutedEventArgs e)
        {
            Frame.Navigate(new Pages.UsersPage());
        }
        private void openRolesPage(object sender, RoutedEventArgs e)
        {
            Frame.Navigate(new Pages.RolesPage());
        }
    }
}