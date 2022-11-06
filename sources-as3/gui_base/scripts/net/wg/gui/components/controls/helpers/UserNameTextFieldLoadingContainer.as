package net.wg.gui.components.controls.helpers
{
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.interfaces.IUserProps;
   
   public class UserNameTextFieldLoadingContainer extends TextFieldLoadingContainer
   {
       
      
      public function UserNameTextFieldLoadingContainer()
      {
         super(TextLoadingStyle.LOADING_STYLE_NAME);
      }
      
      public function setUserNameFromProps(param1:IUserProps) : String
      {
         if(_textField != null)
         {
            App.utils.commons.formatPlayerName(_textField,param1);
            return _textField.htmlText;
         }
         return Values.EMPTY_STR;
      }
   }
}
