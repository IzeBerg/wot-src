package net.wg.gui.components.advanced.backButton
{
   import org.idmedia.as3commons.util.StringUtils;
   
   public final class BackButtonHelper
   {
      
      private static var _instance:BackButtonHelper = null;
       
      
      public function BackButtonHelper()
      {
         super();
         _instance = this;
      }
      
      public static function getInstance() : BackButtonHelper
      {
         if(_instance == null)
         {
            _instance = new BackButtonHelper();
         }
         return _instance;
      }
      
      public function updateStatesWidth(param1:BackButtonStates) : void
      {
         if(StringUtils.isNotEmpty(param1.textMc.textField.text))
         {
            App.utils.commons.updateTextFieldSize(param1.textMc.textField,true,false);
         }
         else
         {
            param1.textMc.textField.width = 0;
         }
      }
   }
}
