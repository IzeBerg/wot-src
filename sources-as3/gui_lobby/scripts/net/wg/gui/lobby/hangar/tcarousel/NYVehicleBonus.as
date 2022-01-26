package net.wg.gui.lobby.hangar.tcarousel
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class NYVehicleBonus extends Sprite implements IDisposable
   {
       
      
      public var bonusValue:TextField = null;
      
      public var icon:Image = null;
      
      public var shadow:Sprite = null;
      
      public function NYVehicleBonus()
      {
         super();
         this.bonusValue.autoSize = TextFieldAutoSize.LEFT;
         this.icon.addEventListener(Event.CHANGE,this.onIconChangeHandler);
      }
      
      public function dispose() : void
      {
         this.icon.removeEventListener(Event.CHANGE,this.onIconChangeHandler);
         this.icon.dispose();
         this.icon = null;
         this.bonusValue = null;
         this.shadow = null;
      }
      
      public function updateBonus(param1:String, param2:String) : void
      {
         this.bonusValue.htmlText = param1;
         this.icon.source = param2;
         this.updateLayout();
      }
      
      private function updateLayout() : void
      {
         this.icon.x = this.shadow.width - this.bonusValue.width - this.icon.width >> 1;
         this.bonusValue.x = this.icon.x + this.icon.width >> 0;
         this.bonusValue.y = this.shadow.height - this.bonusValue.height >> 1;
         this.icon.y = this.shadow.height - this.icon.height >> 1;
      }
      
      private function onIconChangeHandler(param1:Event) : void
      {
         this.updateLayout();
      }
   }
}
