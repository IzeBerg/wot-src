package net.wg.gui.battle.commander.views.spawnMenu.items
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import net.wg.gui.battle.commander.views.spawnMenu.VO.BaseRosterVO;
   import net.wg.gui.battle.commander.views.spawnMenu.map.entries.components.VehicleType;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.infrastructure.interfaces.ICursorManager;
   
   public class DragItem extends BattleUIComponent
   {
      
      private static const _BG_OFFSET:uint = 12;
      
      private static const _CURSOR_OFFSET_X:int = 7;
      
      private static const _CURSOR_OFFSET_Y:int = 14;
       
      
      public var background:MovieClip = null;
      
      public var vehicleType:VehicleType = null;
      
      private var _cursorMgr:ICursorManager;
      
      public function DragItem()
      {
         this._cursorMgr = App.cursor;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.vehicleType.addEventListener(Event.RESIZE,this.handleVehicleTypeResized);
         this.vehicleType.isCursor = true;
      }
      
      override protected function onDispose() : void
      {
         this.detach();
         this.vehicleType.removeEventListener(Event.RESIZE,this.handleVehicleTypeResized);
         this.vehicleType.dispose();
         this.vehicleType = null;
         this.background = null;
         this._cursorMgr = null;
         super.onDispose();
      }
      
      public function attach(param1:BaseRosterVO) : void
      {
         if(param1)
         {
            this.vehicleType.vehicleType = param1.vehicleType;
            this.vehicleType.vehicleName = param1.vehicleName;
            this._cursorMgr.attachToCursor(this,_CURSOR_OFFSET_X,_CURSOR_OFFSET_Y);
         }
         else if(this._cursorMgr.getAttachedSprite())
         {
            this._cursorMgr.detachFromCursor();
         }
      }
      
      public function detach() : void
      {
         this.attach(null);
      }
      
      private function handleVehicleTypeResized(param1:Event) : void
      {
         this.background.width = this.vehicleType.x + this.vehicleType.width + _BG_OFFSET;
      }
   }
}
