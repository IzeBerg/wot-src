package net.wg.gui.lobby.personalMissions.components.statusFooter
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.gui.components.controls.TableRenderer;
   import net.wg.gui.lobby.personalMissions.data.PawnedSheetVO;
   import net.wg.gui.lobby.personalMissions.events.PawnedSheetRendererEvent;
   import net.wg.infrastructure.managers.ITooltipMgr;
   
   public class PawnedSheetListRenderer extends TableRenderer
   {
       
      
      public var taskTf:TextField = null;
      
      public var descrTf:TextField = null;
      
      public var arrow:Sprite = null;
      
      public var blink:MovieClip = null;
      
      public var taskTfHit:MovieClip = null;
      
      public var descrTfHit:MovieClip = null;
      
      private var _taskId:String;
      
      private var _blinkAnimHasBeenPlayed:Boolean = false;
      
      private var _titleTooltip:String;
      
      private var _descrTooltip:String;
      
      private var _isTitleTruncated:Boolean = false;
      
      private var _isDescrTruncated:Boolean = false;
      
      private var _toolTipMgr:ITooltipMgr;
      
      public function PawnedSheetListRenderer()
      {
         this._toolTipMgr = App.toolTipMgr;
         super();
      }
      
      override public function setData(param1:Object) : void
      {
         var _loc2_:PawnedSheetVO = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         super.setData(param1);
         if(param1 != null)
         {
            _loc2_ = PawnedSheetVO(param1);
            this.taskTf.htmlText = _loc2_.taskText;
            this._titleTooltip = this.taskTf.text;
            _loc3_ = App.utils.commons.truncateTextFieldText(this.taskTf,_loc2_.taskText,true,true);
            this._isTitleTruncated = _loc3_.length < _loc2_.taskText.length;
            this.taskTfHit.visible = this._isTitleTruncated;
            this.descrTf.htmlText = _loc2_.descrText;
            this._descrTooltip = this.descrTf.text;
            _loc4_ = App.utils.commons.truncateTextFieldText(this.descrTf,_loc2_.descrText,true,true);
            this._isDescrTruncated = _loc4_.length < _loc2_.descrText.length;
            this.descrTfHit.visible = this._isDescrTruncated;
            this._taskId = _loc2_.taskId;
            if(_loc2_.animDelay >= 0 && !this._blinkAnimHasBeenPlayed)
            {
               App.utils.scheduler.scheduleTask(this.startBlinkAnim,_loc2_.animDelay);
            }
         }
      }
      
      override protected function onDispose() : void
      {
         App.utils.scheduler.cancelTask(this.startBlinkAnim);
         this.taskTfHit.removeEventListener(MouseEvent.ROLL_OVER,this.onTaskTfHitRollOverHandler);
         this.taskTfHit.removeEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
         this.descrTfHit.removeEventListener(MouseEvent.ROLL_OVER,this.onDescrTfHitRollOverHandler);
         this.descrTfHit.removeEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
         this.taskTf = null;
         this.descrTf = null;
         this.taskTfHit = null;
         this.descrTfHit = null;
         this.arrow = null;
         this.blink.stop();
         this.blink = null;
         this._toolTipMgr = null;
         super.onDispose();
      }
      
      override protected function handleClick(param1:uint = 0) : void
      {
         super.handleClick(param1);
         dispatchEvent(new PawnedSheetRendererEvent(PawnedSheetRendererEvent.CLICK,this._taskId,true));
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this.blink.visible = false;
         this.blink.stop();
         this.blink.mouseChildren = this.blink.mouseEnabled = false;
         this.arrow.mouseChildren = this.arrow.mouseEnabled = false;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         buttonMode = true;
         useHandCursor = true;
         mouseChildren = true;
         rendererBg.mouseChildren = false;
         rendererBg.buttonMode = true;
         this.taskTf.mouseEnabled = this.descrTf.mouseEnabled = false;
         this.taskTfHit.buttonMode = this.descrTfHit.buttonMode = true;
         this.taskTfHit.addEventListener(MouseEvent.ROLL_OVER,this.onTaskTfHitRollOverHandler);
         this.taskTfHit.addEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
         this.descrTfHit.addEventListener(MouseEvent.ROLL_OVER,this.onDescrTfHitRollOverHandler);
         this.descrTfHit.addEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
      }
      
      private function startBlinkAnim() : void
      {
         this.blink.visible = true;
         this.blink.gotoAndPlay(1);
         this._blinkAnimHasBeenPlayed = true;
      }
      
      private function onComponentRollOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
      
      private function onDescrTfHitRollOverHandler(param1:MouseEvent) : void
      {
         if(this._isDescrTruncated)
         {
            this._toolTipMgr.show(this._descrTooltip);
         }
      }
      
      private function onTaskTfHitRollOverHandler(param1:MouseEvent) : void
      {
         if(this._isTitleTruncated)
         {
            this._toolTipMgr.show(this._titleTooltip);
         }
      }
   }
}
