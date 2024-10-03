package net.wg.gui.lobby.hangar.vehicleParameters.components
{
   import flash.text.TextField;
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.base.SimpleDisposable;
   
   public class VehParamAbility extends SimpleDisposable
   {
       
      
      public var bg:Image = null;
      
      public var textFieldTF:TextField = null;
      
      public function VehParamAbility()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.bg.dispose();
         this.bg = null;
         this.textFieldTF = null;
         super.onDispose();
      }
      
      public function updateData(param1:String, param2:String) : void
      {
         this.bg.source = param1;
         this.textFieldTF.htmlText = param2;
      }
   }
}
