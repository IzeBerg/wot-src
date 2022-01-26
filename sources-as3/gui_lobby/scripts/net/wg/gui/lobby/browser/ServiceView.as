package net.wg.gui.lobby.browser
{
   import flash.text.TextField;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class ServiceView extends UIComponentEx
   {
       
      
      public var headerTF:TextField;
      
      public var descriptionTF:TextField;
      
      public function ServiceView()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
      }
      
      override protected function onDispose() : void
      {
         this.headerTF = null;
         this.descriptionTF = null;
         super.onDispose();
      }
      
      public function setData(param1:String, param2:String) : void
      {
         this.headerTF.htmlText = param1;
         this.descriptionTF.htmlText = param2;
         App.utils.commons.updateTextFieldSize(this.descriptionTF,false,true);
         setSize(this.actualWidth,this.actualHeight);
      }
   }
}
