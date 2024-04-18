package net.wg.gui.lobby.reservesPanel.components
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public class ReserveParamsItemRenderer extends MovieClip
   {
       
      
      public var paramValuesField:TextField;
      
      public var paramNamesField:TextField;
      
      public function ReserveParamsItemRenderer()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this.paramValuesField = null;
         this.paramNamesField = null;
      }
      
      public function setData(param1:String, param2:String) : void
      {
         this.paramValuesField.htmlText = param1;
         this.paramNamesField.htmlText = param2;
         App.utils.commons.updateTextFieldSize(this.paramValuesField,false,true);
         App.utils.commons.updateTextFieldSize(this.paramNamesField,false,true);
      }
   }
}
