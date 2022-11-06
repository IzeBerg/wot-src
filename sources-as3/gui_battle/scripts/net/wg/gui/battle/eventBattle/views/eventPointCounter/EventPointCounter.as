package net.wg.gui.battle.eventBattle.views.eventPointCounter
{
   import flash.display.MovieClip;
   import net.wg.gui.eventcomponents.NumberProgress;
   import net.wg.infrastructure.base.meta.IEventPointCounterMeta;
   import net.wg.infrastructure.base.meta.impl.EventPointCounterMeta;
   
   public class EventPointCounter extends EventPointCounterMeta implements IEventPointCounterMeta
   {
      
      private static const APPEAR:String = "appear";
      
      private static const DISAPPEAR:String = "disappear";
       
      
      public var num:NumberProgress = null;
      
      public var fx:MovieClip = null;
      
      public var mc:MovieClip = null;
      
      public var appearFx:MovieClip = null;
      
      public var disappearFx:MovieClip = null;
      
      private var _count:int = 0;
      
      public function EventPointCounter()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.num.dispose();
         this.num = null;
         this.fx = null;
         this.mc = null;
         this.appearFx = null;
         this.disappearFx = null;
         super.onDispose();
      }
      
      public function as_updateCount(param1:int) : void
      {
         if(this._count != param1)
         {
            this._count = param1;
            if(this._count > 0)
            {
               gotoAndPlay(APPEAR);
               this.appearFx.gotoAndPlay(APPEAR);
            }
            else if(this._count == 0)
            {
               gotoAndPlay(DISAPPEAR);
               this.disappearFx.gotoAndPlay(APPEAR);
            }
            this.num.setText(this._count.toString());
         }
      }
   }
}
