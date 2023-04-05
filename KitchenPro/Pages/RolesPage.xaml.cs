using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Windows;
using System.Windows.Controls;

namespace KitchenPro.Pages
{
    public partial class RolesPage : Page
    {
        public RolesPage()
        {
            InitializeComponent();
            DataContext = this;
            UpdateGrid(null);
            DlgLoad(false, "");
        }

        private int DlgMode = 0;
        public Base.Role SelectedItem;
        public ObservableCollection<Base.Role> Roles;

        private void Page_Loaded(object sender, RoutedEventArgs e)
        {
            List<string> Columns = new List<string>();
            for (int i = 0; i < 1; i++)
            {
                Columns.Add(PageGrid.Columns[i].Header.ToString());
            }
            foreach (DataGridColumn Column in PageGrid.Columns)
            {
                Column.CanUserSort = false;
            }
        }

        private void UpdateGrid(Base.Role role)
        {
            if ((role == null) && (PageGrid.ItemsSource != null))
            {
                role = (Base.Role)PageGrid.SelectedItem;
            }
            Roles = new ObservableCollection<Base.Role>(SourceCore.db.Role);
            PageGrid.ItemsSource = Roles;
            PageGrid.SelectedItem = role;
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
            RecordTextRolename.Text = SelectedItem.RoleName;
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
                SelectedItem = (Base.Role)PageGrid.SelectedItem;
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
                SelectedItem = (Base.Role)PageGrid.SelectedItem;
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
                    Base.Role SelectingAccessory = (Base.Role)PageGrid.SelectedItem;
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

        private void AddCommit_Click(object sender, RoutedEventArgs e)
        {
            StringBuilder errors = new StringBuilder();

            if (string.IsNullOrEmpty(RecordTextRolename.Text)) errors.AppendLine("Укажите название роли");
            if (errors.Length > 0)
            {
                MessageBox.Show(errors.ToString());
                return;
            }

            if (DlgMode == 0)
            {
                var NewBase = new Base.Role();
                NewBase.RoleName = RecordTextRolename.Text.Trim();
                SourceCore.db.Role.Add(NewBase);
                SelectedItem = NewBase;
            }
            else
            {
                var EditBase = new Base.Role();
                EditBase = SourceCore.db.Role.First(p => p.RoleID == SelectedItem.RoleID);
                EditBase.RoleName = RecordTextRolename.Text.Trim();
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