package net.wg.gui.battle.battleRoyale.views.components.fullStats.nationsVehiclesCounter
{
   import flash.display.Sprite;
   import flash.events.Event;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.battle.battleRoyale.views.components.fullStats.nationsVehiclesCounter.data.BattleRoyaleNationsVehiclesCounterVO;
   import net.wg.gui.battle.battleRoyale.views.components.fullStats.nationsVehiclesCounter.data.BattleRoyaleNationsVehiclesVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class BattleRoyaleNationsVehiclesCounter extends Sprite implements IDisposable
   {
      
      private static const RENDERER_PADDING_BOTTOM:uint = 5;
       
      
      private var renderers:Vector.<BattleRoyaleNationsVehiclesRenderer> = null;
      
      private var _renderersByType:Object = null;
      
      private var _lastRenderer:BattleRoyaleNationsVehiclesRenderer = null;
      
      private var _data:BattleRoyaleNationsVehiclesCounterVO = null;
      
      private var _disposed:Boolean = false;
      
      public function BattleRoyaleNationsVehiclesCounter()
      {
         super();
         this.renderers = new Vector.<BattleRoyaleNationsVehiclesRenderer>(0);
         this._renderersByType = {};
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.cleanUpVehiclesRenderers();
         this.renderers = null;
         App.utils.data.cleanupDynamicObject(this._renderersByType);
         this._renderersByType = null;
         this._lastRenderer.removeEventListener(Event.RESIZE,this.onLastRendererResizeHandler);
         this._lastRenderer = null;
         this._data = null;
      }
      
      public function setData(param1:BattleRoyaleNationsVehiclesCounterVO) : void
      {
         var _loc2_:BattleRoyaleNationsVehiclesCounterVO = null;
         if(param1)
         {
            _loc2_ = this._data;
            this._data = param1;
            if(!_loc2_ || _loc2_.vehicles.length < this._data.vehicles.length)
            {
               this.createVehiclesRenderers();
            }
            this.updateVehiclesRenderers();
         }
      }
      
      private function cleanUpVehiclesRenderers() : void
      {
         var _loc1_:BattleRoyaleNationsVehiclesRenderer = null;
         for each(_loc1_ in this.renderers)
         {
            if(_loc1_ && contains(_loc1_))
            {
               removeChild(_loc1_);
               _loc1_.dispose();
            }
         }
         if(this.renderers && this.renderers.length > 0)
         {
            this.renderers.splice(0,this.renderers.length);
         }
      }
      
      private function createVehiclesRenderers() : void
      {
         var _loc1_:Vector.<BattleRoyaleNationsVehiclesVO> = this._data.vehicles;
         var _loc2_:uint = _loc1_.length;
         if(_loc2_ <= this.renderers.length)
         {
            return;
         }
         var _loc3_:BattleRoyaleNationsVehiclesVO = null;
         var _loc4_:BattleRoyaleNationsVehiclesRenderer = null;
         var _loc5_:Class = App.utils.classFactory.getClass(Linkages.NATIONS_VEHICLES_RENDERER);
         var _loc6_:Boolean = true;
         var _loc7_:uint = 0;
         while(_loc7_ < _loc2_)
         {
            _loc3_ = _loc1_[_loc7_];
            _loc6_ = !Boolean(this._renderersByType[_loc3_.classType]);
            if(_loc6_)
            {
               _loc4_ = new _loc5_();
               _loc4_.classType = _loc3_.classType;
               addChild(_loc4_);
               this.renderers.push(_loc4_);
               this._renderersByType[_loc3_.classType] = _loc4_;
            }
            _loc6_ = true;
            _loc7_++;
         }
         if(_loc4_)
         {
            if(this._lastRenderer)
            {
               this._lastRenderer.removeEventListener(Event.RESIZE,this.onLastRendererResizeHandler);
            }
            for each(_loc4_ in this.renderers)
            {
               _loc4_.separatorVisible = true;
            }
            this._lastRenderer = _loc4_;
            this._lastRenderer.separatorVisible = false;
            this._lastRenderer.addEventListener(Event.RESIZE,this.onLastRendererResizeHandler);
         }
      }
      
      private function updateVehiclesRenderers() : void
      {
         var _loc3_:BattleRoyaleNationsVehiclesVO = null;
         var _loc1_:Vector.<BattleRoyaleNationsVehiclesVO> = this._data.vehicles;
         var _loc2_:BattleRoyaleNationsVehiclesRenderer = null;
         for each(_loc3_ in _loc1_)
         {
            _loc2_ = this._renderersByType[_loc3_.classType];
            if(_loc2_)
            {
               _loc2_.vehiclesCount = _loc3_.platoonsAlive;
               _loc2_.dataProvider = _loc3_.platoons;
            }
         }
      }
      
      public function set useSmallLayout(param1:Boolean) : void
      {
         var _loc2_:BattleRoyaleNationsVehiclesRenderer = null;
         for each(_loc2_ in this.renderers)
         {
            _loc2_.useSmallLayout = param1;
         }
      }
      
      private function onLastRendererResizeHandler(param1:Event) : void
      {
         var _loc2_:uint = this.renderers.length;
         var _loc3_:BattleRoyaleNationsVehiclesRenderer = null;
         var _loc4_:BattleRoyaleNationsVehiclesRenderer = null;
         var _loc5_:uint = 1;
         while(_loc5_ < _loc2_)
         {
            _loc3_ = this.renderers[_loc5_ - 1];
            _loc4_ = this.renderers[_loc5_];
            _loc4_.y = _loc3_.y + _loc3_.height + RENDERER_PADDING_BOTTOM | 0;
            _loc5_++;
         }
         dispatchEvent(new Event(Event.RESIZE));
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
