package net.wg.gui.components.questProgress.components.headerProgress
{
   import flash.text.TextField;
   import net.wg.gui.components.questProgress.interfaces.data.IHeaderProgressData;
   
   public class HeaderProgressItemValue extends HeaderProgressItemSimple
   {
       
      
      public var valueTitleTf:TextField = null;
      
      public function HeaderProgressItemValue()
      {
         super();
      }
      
      override protected function onDataUpdate(param1:IHeaderProgressData, param2:int) : void
      {
         this.valueTitleTf.htmlText = param1.valueTitle;
         App.utils.commons.updateTextFieldSize(this.valueTitleTf,true,false);
         super.onDataUpdate(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         this.valueTitleTf = null;
         super.onDispose();
      }
   }
}
