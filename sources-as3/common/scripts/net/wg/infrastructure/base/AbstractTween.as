package net.wg.infrastructure.base
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.TweenActionsOnRemove;
   import net.wg.infrastructure.base.meta.impl.AbstractTweenMeta;
   import net.wg.infrastructure.interfaces.ITween;
   import net.wg.infrastructure.interfaces.ITweenHandler;
   import net.wg.infrastructure.interfaces.ITweenPropertiesVO;
   import net.wg.utils.IAssertable;
   import net.wg.utils.IScheduler;
   import org.idmedia.as3commons.lang.IllegalStateException;
   
   public class AbstractTween extends AbstractTweenMeta implements ITween
   {
       
      
      private var _props:ITweenPropertiesVO = null;
      
      private var _handler:ITweenHandler = null;
      
      private var _memberData:Object;
      
      public function AbstractTween()
      {
         super();
      }
      
      public function getTargetDisplayObject() : DisplayObject
      {
         return this._props.getTarget();
      }
      
      public function setHandler(param1:ITweenHandler) : void
      {
         this._handler = param1;
      }
      
      public function onAnimComplete() : void
      {
         if(this._handler != null)
         {
            this._handler.onComplete(this);
         }
      }
      
      public function onAnimStart() : void
      {
         if(this._handler != null)
         {
            this._handler.onStart(this);
         }
      }
      
      public function get memberData() : Object
      {
         return this._memberData;
      }
      
      public function set memberData(param1:Object) : void
      {
         this._memberData = param1;
      }
      
      public function get props() : ITweenPropertiesVO
      {
         return this._props;
      }
      
      public function set props(param1:ITweenPropertiesVO) : void
      {
         this.asserter.assertNotNull(param1,"props in Tween " + Errors.CANT_NULL);
         var _loc2_:DisplayObject = param1.getTarget();
         this.asserter.assertNotNull(_loc2_,"_props.target in Tween " + Errors.CANT_NULL);
         this.asserter.assertNotNull(_loc2_.stage,"target.stage in Tween " + Errors.CANT_NULL);
         var _loc3_:int = param1.getDuration();
         this.asserter.assertNotNull(_loc3_,"_props.duration " + Errors.CANT_NULL);
         this.asserter.assert(_loc3_ > 0,"_props.duration has not maintained value");
         var _loc4_:ITweenHandler = param1.getHandler();
         if(_loc4_ != null)
         {
            this.setHandler(_loc4_);
         }
         this._props = param1;
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         initialiazeS(this._props);
         this._props.getTarget().addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
         this.scheduler.scheduleOnNextFrame(postponedCheckStateS);
      }
      
      override protected function onDispose() : void
      {
         this.scheduler.cancelTask(postponedCheckStateS);
         this.asserter.assertNotNull(this._props,"props in Tween " + Errors.CANT_NULL);
         var _loc1_:DisplayObject = this._props.getTarget();
         this.asserter.assertNotNull(_loc1_,"_props.target in Tween " + Errors.CANT_NULL);
         _loc1_.removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
         this._props.dispose();
         this._props = null;
         this._handler = null;
         this._memberData = null;
         super.onDispose();
      }
      
      private function get scheduler() : IScheduler
      {
         return App.utils.scheduler;
      }
      
      private function get asserter() : IAssertable
      {
         return App.utils.asserter;
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         var _loc2_:String = null;
         switch(this._props.getActionAfterRemoveFromStage())
         {
            case TweenActionsOnRemove.STOP:
               setPausedS(true);
               break;
            case TweenActionsOnRemove.NOT_TO_PROCESS:
               break;
            default:
               _loc2_ = "unknown actionAfterRemoveFromStage value: " + this._props.getActionAfterRemoveFromStage();
               throw new IllegalStateException(_loc2_);
         }
      }
   }
}
