using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Windows;
using System.Windows.Controls;

namespace KitchenPro.Pages
{
    public partial class UsersPage : Page
    {
        public UsersPage()
        {
            InitializeComponent();
            DataContext = this;
            UpdateGrid(null);
            DlgLoad(false, "");
            RecordComboBoxIsAdmin.ItemsSource = SourceCore.db.Role.ToList();
        }

        private int DlgMode = 0;
        public Base.User SelectedItem;
        public ObservableCollection<Base.User> Users;

        private void Page_Loaded(object sender, RoutedEventArgs e)
        {
            List<string> Columns = new List<string>();
            for (int i = 0; i < 4; i++)
            {
                Columns.Add(PageGrid.Columns[i].Header.ToString());
            }
            FilterComboBox.ItemsSource = Columns;
            FilterComboBox.SelectedIndex = 0;

            foreach (DataGridColumn Column in PageGrid.Columns)
            {
                Column.CanUserSort = false;
            }
        }

        private void UpdateGrid(Base.User user)
        {
            if ((user == null) && (PageGrid.ItemsSource != null))
            {
                user = (Base.User)PageGrid.SelectedItem;
            }
            Users = new ObservableCollection<Base.User>(SourceCore.db.User);
            PageGrid.ItemsSource = Users;
            PageGrid.SelectedItem = user;
        }

        private void DlgLoad(bool b, string DlgModeContent)
        {
            if (b == true)
            {
                ColumnChange.Width = new GridLength(300);
                PageGrid.IsHitTestVisible = false;
                RecordLabel.Content = DlgModeContent + " запись";
                AddCommit.Content = DlgModeContent;
                RecordAdd.IsEnabled = false;
                RecordCopy.IsEnabled = false;
                RecordEdit.IsEnabled = false;
                RecordDellete.IsEnabled = false;
            }
            else
            {
                ColumnChange.Width = new GridLength(0);
                PageGrid.IsHitTestVisible = true;
                RecordAdd.IsEnabled = true;
                RecordCopy.IsEnabled = true;
                RecordEdit.IsEnabled = true;
                RecordDellete.IsEnabled = true;
                DlgMode = -1;
            }
        }

        private void FillTextBox()
        {
            RecordTextLogin.Text = SelectedItem.UserLogin;
            RecordTextSurname.Text = SelectedItem.UserSurname;
            RecordTextName.Text = SelectedItem.UserName;
            RecordTextPatronymic.Text = SelectedItem.UserPatronymic;
            RecordComboBoxIsAdmin.Text = SelectedItem.Role.RoleName.ToString();
            RecordTextPassword.Text = SelectedItem.UserPassword;
        }
        private void RecordAdd_Click(object sender, RoutedEventArgs e)
        {
            DlgLoad(true, "Добавить");
            DataContext = null;
            DlgMode = 0;
        }

        private void RecordkCopy_Click(object sender, RoutedEventArgs e)
        {
            if (PageGrid.SelectedItem != null)
            {
                DlgLoad(true, "Копировать");
                SelectedItem = (Base.User)PageGrid.SelectedItem;
                FillTextBox();
                DlgMode = 0;
            }
            else
            {
                MessageBox.Show("Не выбрано ни одной строки!", "Сообщение", MessageBoxButton.OK);
            }
        }

        private void RecordEdit_Click(object sender, RoutedEventArgs e)
        {
            if (PageGrid.SelectedItem != null)
            {
                DlgLoad(true, "Изменить");
                SelectedItem = (Base.User)PageGrid.SelectedItem;
                FillTextBox();
            }
            else
            {
                MessageBox.Show("Не выбрано ни одной строки!", "Сообщение", MessageBoxButton.OK);
            }
        }

        private void RecordDelete_Click(object sender, RoutedEventArgs e)
        {
            if (MessageBox.Show("Удалить запись?", "Внимание", MessageBoxButton.OKCancel, MessageBoxImage.Warning) == MessageBoxResult.OK)
            {

                try
                {
                    Base.User DeletingAccessory = (Base.User)PageGrid.SelectedItem;
                    if (PageGrid.SelectedIndex < PageGrid.Items.Count - 1)
                    {
                        PageGrid.SelectedIndex++;
                    }
                    else
                    {
                        if (PageGrid.SelectedIndex > 0)
                        {
                            PageGrid.SelectedIndex--;
                        }
                    }
                    Base.User SelectingAccessory = (Base.User)PageGrid.SelectedItem;
                    SourceCore.db.User.Remove(DeletingAccessory);
                    SourceCore.db.SaveChanges();
                    UpdateGrid(SelectingAccessory);
                }
                catch
                {

                    MessageBox.Show("Невозможно удалить запись, так как она используется в других справочниках базы данных.",
                    "Предупреждение", MessageBoxButton.OK, MessageBoxImage.Warning, MessageBoxResult.None);
                }
            }
        }

        private void FilterTextBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            var textbox = sender as TextBox;
            switch (FilterComboBox.SelectedIndex)
            {
                case 0:
                    PageGrid.ItemsSource = SourceCore.db.User.Where(q => q.UserSurname.Contains(textbox.Text)).ToList();
                    break;
                case 1:
                    PageGrid.ItemsSource = SourceCore.db.User.Where(q => q.UserName.ToString().Contains(textbox.Text)).ToList();
                    break;
                case 2:
                    PageGrid.ItemsSource = SourceCore.db.User.Where(q => q.UserPatronymic.ToString().Contains(textbox.Text)).ToList();
                    break;
                case 3:
                    PageGrid.ItemsSource = SourceCore.db.User.Where(q => q.Role.RoleName.ToString().Contains(textbox.Text)).ToList();
                    break;
            }
        }

        private void AddCommit_Click(object sender, RoutedEventArgs e)
        {
            StringBuilder errors = new StringBuilder();

            if (string.IsNullOrEmpty(RecordTextSurname.Text)) errors.AppendLine("Укажите фамилию пользователя");
            if (string.IsNullOrEmpty(RecordTextName.Text))errors.AppendLine("Укажите имя пользователя");
            if (string.IsNullOrEmpty(RecordTextPatronymic.Text)) errors.AppendLine("Укажите отчество пользователя");
            if (string.IsNullOrEmpty(RecordTextLogin.Text)) errors.AppendLine("Укажите логин пользователя");
            if (string.IsNullOrEmpty(RecordTextPassword.Text)) errors.AppendLine("Укажите пароль пользователя");
            if ((Base.Role)RecordComboBoxIsAdmin.SelectedItem == null) errors.AppendLine("Укажите роль");
            if (errors.Length > 0)
            {
                MessageBox.Show(errors.ToString());
                return;
            }

            if (DlgMode == 0)
            {
                var NewBase = new Base.User();
                NewBase.UserSurname = RecordTextSurname.Text.Trim();
                NewBase.UserName = RecordTextName.Text.Trim();
                NewBase.UserPatronymic = RecordTextPatronymic.Text.Trim();
                NewBase.UserLogin = RecordTextLogin.Text.Trim();
                NewBase.Role = (Base.Role)RecordComboBoxIsAdmin.SelectedItem;
                NewBase.UserPassword = RecordTextPassword.Text.Trim();
                SourceCore.db.User.Add(NewBase);
                SelectedItem = NewBase;
            }
            else
            {
                var EditBase = new Base.User();
                EditBase = SourceCore.db.User.First(p => p.UserID == SelectedItem.UserID);
                EditBase.UserSurname = RecordTextSurname.Text.Trim();
                EditBase.UserName = RecordTextName.Text.Trim();
                EditBase.UserPatronymic = RecordTextPatronymic.Text.Trim();
                EditBase.UserLogin = RecordTextLogin.Text.Trim();
                EditBase.Role = (Base.Role)RecordComboBoxIsAdmin.SelectedItem;
                EditBase.UserPassword = RecordTextPassword.Text.Trim();
            }

            try
            {
                SourceCore.db.SaveChanges();
                UpdateGrid(SelectedItem);
                DlgLoad(false, "");
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());
            }
        }

        private void AddRollback_Click(object sender, RoutedEventArgs e)
        {
            UpdateGrid(SelectedItem);
            DlgLoad(false, "");
        }
    }
}