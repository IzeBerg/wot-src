package net.wg.gui.battle.views.damagePanel.components
{
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class DamagePanelItemClickArea extends Sprite implements IDisposable
   {
      
      private static const HIT_AREA_COLOR:int = 0;
      
      private static const HIT_AREA_ALPHA:int = 0;
       
      
      private var _itemName:String;
      
      public function DamagePanelItemClickArea(param1:String, param2:int, param3:int, param4:int)
      {
         super();
         this._itemName = param1;
         graphics.beginFill(HIT_AREA_COLOR,HIT_AREA_ALPHA);
         var _loc5_:int = param2 - (param4 << 1);
         var _loc6_:int = param3 - (param4 << 1);
         graphics.drawRect(param4,param4,_loc5_,_loc6_);
         useHandCursor = buttonMode = true;
      }
      
      public function dispose() : void
      {
         graphics.clear();
      }
      
      public function get itemName() : String
      {
         return this._itemName;
      }
      
      public function set itemName(param1:String) : void
      {
         this._itemName = param1;
      }
   }
}
