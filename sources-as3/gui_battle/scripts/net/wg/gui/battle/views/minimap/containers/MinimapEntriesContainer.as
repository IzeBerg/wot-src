package net.wg.gui.battle.views.minimap.containers
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class MinimapEntriesContainer extends Sprite implements IDisposable
   {
       
      
      public var points:Sprite = null;
      
      public var icons:Sprite = null;
      
      public var equipments:Sprite = null;
      
      public var deadVehicles:Sprite = null;
      
      public var aliveVehicles:Sprite = null;
      
      public var personal:Sprite = null;
      
      public var flags:Sprite = null;
      
      private var _disposed:Boolean = false;
      
      public function MinimapEntriesContainer()
      {
         super();
         mouseEnabled = false;
         this.disableChild(this.icons);
         this.disableChild(this.equipments);
         this.disableChild(this.deadVehicles);
         this.disableChild(this.aliveVehicles);
         this.disableChild(this.personal);
         this.disableChild(this.flags);
         this.icons.mouseEnabled = this.equipments.mouseEnabled = this.deadVehicles.mouseEnabled = this.aliveVehicles.mouseEnabled = this.personal.mouseEnabled = this.flags.mouseEnabled = false;
         this.icons.mouseChildren = this.equipments.mouseChildren = this.deadVehicles.mouseChildren = this.aliveVehicles.mouseChildren = this.personal.mouseChildren = this.flags.mouseChildren = false;
         this.points.mouseEnabled = false;
      }
      
      private function disableChild(param1:DisplayObject) : void
      {
         var _loc2_:InteractiveObject = null;
         var _loc3_:DisplayObjectContainer = null;
         var _loc4_:int = 0;
         var _loc5_:DisplayObject = null;
         var _loc6_:InteractiveObject = null;
         var _loc7_:DisplayObjectContainer = null;
         if(param1 is InteractiveObject)
         {
            _loc2_ = InteractiveObject(param1);
            _loc2_.mouseEnabled = false;
         }
         if(param1 is DisplayObjectContainer)
         {
            _loc3_ = DisplayObjectContainer(param1);
            _loc4_ = 0;
            while(_loc4_ < _loc3_.numChildren)
            {
               _loc5_ = _loc3_.getChildAt(_loc4_);
               if(_loc5_ is InteractiveObject)
               {
                  _loc6_ = InteractiveObject(_loc5_);
                  _loc6_.mouseEnabled = false;
               }
               if(_loc5_ is DisplayObjectContainer)
               {
                  _loc7_ = DisplayObjectContainer(_loc5_);
                  if(_loc7_.numChildren > 0)
                  {
                     this.disableChild(_loc7_);
                  }
               }
               _loc4_++;
            }
         }
      }
      
      protected function onDispose() : void
      {
         this.points = null;
         this.icons = null;
         this.equipments = null;
         this.deadVehicles = null;
         this.aliveVehicles = null;
         this.personal = null;
         this.flags = null;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.onDispose();
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
