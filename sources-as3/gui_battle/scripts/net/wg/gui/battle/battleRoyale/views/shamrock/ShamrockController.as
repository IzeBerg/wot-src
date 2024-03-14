package net.wg.gui.battle.battleRoyale.views.shamrock
{
   import flash.events.IEventDispatcher;
   import net.wg.gui.battle.battleRoyale.views.shamrock.events.ShamrockAnimationEvent;
   import net.wg.gui.battle.battleRoyale.views.shamrock.interfaces.IShamrockListener;
   import net.wg.infrastructure.base.meta.IBRShamrockControllerMeta;
   import net.wg.infrastructure.base.meta.impl.BRShamrockControllerMeta;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   
   public class ShamrockController extends BRShamrockControllerMeta implements IBRShamrockControllerMeta, IDAAPIModule
   {
       
      
      private var _listeners:Vector.<IShamrockListener>;
      
      private var _isDAAPIInited:Boolean = false;
      
      public function ShamrockController()
      {
         this._listeners = new Vector.<IShamrockListener>();
         super();
      }
      
      override protected function onPopulate() : void
      {
         this._isDAAPIInited = true;
         super.onPopulate();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IEventDispatcher = null;
         for each(_loc1_ in this._listeners)
         {
            _loc1_.removeEventListener(ShamrockAnimationEvent.COLLECTED,this.onShamrockCollectedHandler);
            _loc1_.removeEventListener(ShamrockAnimationEvent.COLLECT_X3,this.onShamrockCollectX3Handler);
         }
         this._listeners.length = 0;
         this._listeners = null;
         super.onDispose();
      }
      
      public function as_addPoints(param1:int, param2:int, param3:Boolean) : void
      {
         var _loc4_:IShamrockListener = null;
         for each(_loc4_ in this._listeners)
         {
            _loc4_.addShamrocks(param1,param2,param3);
         }
      }
      
      public function as_setCounter(param1:int) : void
      {
         var _loc2_:IShamrockListener = null;
         for each(_loc2_ in this._listeners)
         {
            _loc2_.setShamrocks(param1);
         }
      }
      
      public function registerListener(param1:IShamrockListener) : void
      {
         this._listeners.push(param1);
         param1.addEventListener(ShamrockAnimationEvent.COLLECTED,this.onShamrockCollectedHandler);
         param1.addEventListener(ShamrockAnimationEvent.COLLECT_X3,this.onShamrockCollectX3Handler);
      }
      
      public function get isDAAPIInited() : Boolean
      {
         return this._isDAAPIInited;
      }
      
      private function onShamrockCollectX3Handler(param1:ShamrockAnimationEvent) : void
      {
         var _loc2_:IShamrockListener = null;
         for each(_loc2_ in this._listeners)
         {
            _loc2_.addShamrocks(param1.amount,param1.totalValue,false);
         }
      }
      
      private function onShamrockCollectedHandler(param1:ShamrockAnimationEvent) : void
      {
         var _loc2_:IShamrockListener = null;
         for each(_loc2_ in this._listeners)
         {
            _loc2_.collected(param1.amount,param1.totalValue,param1.isFromTeamMate);
         }
      }
   }
}
