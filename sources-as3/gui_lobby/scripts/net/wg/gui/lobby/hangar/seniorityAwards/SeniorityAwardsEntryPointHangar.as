package net.wg.gui.lobby.hangar.seniorityAwards
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFormatAlign;
   import net.wg.gui.lobby.hangar.eventEntryPoint.EntryPointSize;
   import net.wg.gui.lobby.hangar.eventEntryPoint.IEventEntryPoint;
   import net.wg.infrastructure.managers.counter.CounterManager;
   import net.wg.infrastructure.managers.counter.CounterProps;
   import net.wg.utils.ICounterManager;
   
   public class SeniorityAwardsEntryPointHangar extends SeniorityAwardsEntryPoint implements IEventEntryPoint
   {
      
      private static const HOVER_SHOW_LABEL:String = "show";
      
      private static const HOVER_HIDE_LABEL:String = "hide";
      
      private static const SMALL_FRAME_LBL:String = "small";
      
      private static const BIG_FRAME_LBL:String = "big";
      
      private static const OVER_SOUND:String = "gui_hangar_award_woosh";
      
      private static const HOVER_HIDE_FRAME_IDX:int = 27;
      
      private static const COUNTER_PROPS:CounterProps = new CounterProps(12,-2,TextFormatAlign.RIGHT);
      
      public static const SMALL_MARGINS:Rectangle = new Rectangle(-71,-50,-36,-50);
      
      public static const BIG_MARGINS:Rectangle = new Rectangle(0,-20,-36,-20);
       
      
      public var hover:MovieClip = null;
      
      public var hoverBG:MovieClip = null;
      
      private var _counterMgr:ICounterManager;
      
      private var _size:int;
      
      public function SeniorityAwardsEntryPointHangar()
      {
         this._counterMgr = App.utils.counterManager;
         this._size = EntryPointSize.BIG;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         bounds.addEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
         bounds.addEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
         openBtn.addEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
         this._counterMgr.setCounter(DisplayObject(openBtn),CounterManager.EXCLAMATION_COUNTER_VALUE,null,COUNTER_PROPS);
      }
      
      override protected function onDispose() : void
      {
         bounds.removeEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
         bounds.removeEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
         openBtn.addEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
         this.hover = null;
         this.hoverBG = null;
         this._counterMgr = null;
         super.onDispose();
      }
      
      public function get margin() : Rectangle
      {
         return !!EntryPointSize.isSmall(this._size) ? SMALL_MARGINS : BIG_MARGINS;
      }
      
      public function get size() : int
      {
         return this._size;
      }
      
      public function set size(param1:int) : void
      {
         if(param1 == this._size)
         {
            return;
         }
         this._size = param1;
         if(EntryPointSize.isSmall(this._size))
         {
            gotoAndStop(SMALL_FRAME_LBL);
         }
         else
         {
            gotoAndStop(BIG_FRAME_LBL);
         }
         applyData();
         updatePosition();
      }
      
      private function onMouseRollOverHandler(param1:MouseEvent) : void
      {
         if(this.hover.currentFrame >= HOVER_HIDE_FRAME_IDX)
         {
            this.hover.gotoAndStop(HOVER_HIDE_LABEL);
            this.hoverBG.gotoAndStop(HOVER_HIDE_LABEL);
         }
         else
         {
            this.hover.gotoAndPlay(HOVER_SHOW_LABEL);
            this.hoverBG.gotoAndPlay(HOVER_SHOW_LABEL);
         }
         App.toolTipMgr.showComplex(TOOLTIPS.SENIORITYAWARDS_HANGARENTRYPOINT_TOOLTIP);
         playSoundS(OVER_SOUND);
      }
      
      private function onMouseRollOutHandler(param1:MouseEvent) : void
      {
         this.hover.gotoAndPlay(HOVER_HIDE_LABEL);
         this.hoverBG.gotoAndPlay(HOVER_HIDE_LABEL);
         App.toolTipMgr.hide();
      }
   }
}
