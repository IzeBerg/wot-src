package net.wg.gui.lobby.fortifications.popovers
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Point;
   import net.wg.gui.components.controls.events.DropdownMenuEvent;
   import net.wg.infrastructure.base.SmartPopOverView;
   
   public class PopoverWithDropdown extends SmartPopOverView
   {
       
      
      private var dropdownListRef:MovieClip = null;
      
      private var dropdownListXY:Point = null;
      
      public function PopoverWithDropdown()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         addEventListener(DropdownMenuEvent.SHOW_DROP_DOWN,this.onShowDropdownHandler);
         super.configUI();
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(DropdownMenuEvent.SHOW_DROP_DOWN,this.onShowDropdownHandler);
         if(this.dropdownListRef && contains(this.dropdownListRef))
         {
            removeChild(this.dropdownListRef);
         }
         this.dropdownListRef = null;
         this.dropdownListXY = null;
         super.onDispose();
      }
      
      private function updateDDPosition() : void
      {
         this.dropdownListRef.x = this.dropdownListXY.x;
         this.dropdownListRef.y = this.dropdownListXY.y;
      }
      
      protected function onShowDropdownHandler(param1:DropdownMenuEvent) : void
      {
         this.dropdownListRef = param1.dropDownRef;
         this.dropdownListXY = this.dropdownListRef.parent.localToGlobal(new Point(this.dropdownListRef.x,this.dropdownListRef.y));
         this.dropdownListXY = globalToLocal(this.dropdownListXY);
         addChild(this.dropdownListRef);
         this.dropdownListXY.x |= 0;
         this.dropdownListXY.y |= 0;
         this.updateDDPosition();
         addEventListener(DropdownMenuEvent.CLOSE_DROP_DOWN,this.onHideDropdownHandler);
         stage.addEventListener(Event.RESIZE,this.updateDDListHandler);
      }
      
      private function updateDDListHandler(param1:Event) : void
      {
         this.updateDDPosition();
      }
      
      private function onHideDropdownHandler(param1:DropdownMenuEvent) : void
      {
         removeEventListener(DropdownMenuEvent.CLOSE_DROP_DOWN,this.onHideDropdownHandler);
         if(stage && stage.hasEventListener(Event.RESIZE))
         {
            stage.removeEventListener(Event.RESIZE,this.updateDDListHandler);
         }
      }
   }
}
