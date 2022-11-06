package net.wg.gui.battle.components
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.VO.daapi.DAAPIQuestStatusVO;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.generated.MISSIONS_STATES;
   import net.wg.gui.components.common.FrameStateCmpnt;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class FullStatsTitle extends BattleDisplayable implements IDisposable
   {
      
      private static const WIDTH:int = 920;
      
      private static const TEXT_GAP:int = 12;
      
      private static const BULLET_GAP:int = 2;
      
      private static const BULLET_WIDTH:int = 4;
      
      private static const BULLETS_COUNT:int = 4;
      
      private static const DEVIDERS_COUNT:int = 2;
      
      private static const TEXTFIELD_PADDING:int = 5;
      
      private static const TITLE_TF_MAX_WIDTH:int = 670;
      
      private static const TITLE_TF_Y:int = 0;
      
      private static const TITLE_TF_Y_BIG:int = -8;
      
      private static const STATUS_TF_Y:int = 42;
      
      private static const STATUS_TF_Y_BIG:int = 63;
      
      private static const DEVIDERS_Y:int = 22;
      
      private static const DEVIDERS_Y_BIG:int = 14;
      
      private static const DEVIDERS_ROTATED_Y:int = 24;
      
      private static const DEVIDERS_ROTATED_Y_BIG:int = 16;
      
      private static const STATUS_NORMAL:String = "normal";
       
      
      public var titleTF:TextField = null;
      
      public var bulletRightBright:Sprite = null;
      
      public var bulletRightDim:Sprite = null;
      
      public var deviderRight:Sprite = null;
      
      public var bulletLeftBright:Sprite = null;
      
      public var bulletLeftDim:Sprite = null;
      
      public var deviderLeft:Sprite = null;
      
      public var statusBg:FrameStateCmpnt = null;
      
      public var statusTF:TextField = null;
      
      private var _statusData:DAAPIQuestStatusVO = null;
      
      private var _title:String = null;
      
      private var _tooltipMgr:ITooltipMgr = null;
      
      public function FullStatsTitle()
      {
         super();
         this._tooltipMgr = App.toolTipMgr;
         mouseEnabled = false;
         this.statusBg.mouseEnabled = false;
         this.statusTF.autoSize = TextFieldAutoSize.CENTER;
         this.statusTF.addEventListener(MouseEvent.MOUSE_OVER,this.onStatusTfMouseOverHandler);
         this.statusTF.addEventListener(MouseEvent.MOUSE_OUT,this.onStatusTfMouseOutHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(this._statusData != null)
            {
               if(StringUtils.isNotEmpty(this._statusData.status))
               {
                  this.statusBg.frameLabel = this._statusData.status;
                  this.statusTF.htmlText = this._statusData.statusLabel;
                  this.statusTF.visible = true;
               }
               else
               {
                  this.statusBg.frameLabel = STATUS_NORMAL;
                  this.statusTF.visible = false;
               }
            }
            if(StringUtils.isNotEmpty(this._title))
            {
               this.titleTF.htmlText = this._title;
            }
            invalidateSize();
         }
         if(this._statusData != null && isInvalid(InvalidationType.SIZE))
         {
            this.titleTF.width = TITLE_TF_MAX_WIDTH;
            if(this.titleTF.numLines == 1)
            {
               App.utils.commons.updateTextFieldSize(this.titleTF,true,false);
               this.titleTF.y = TITLE_TF_Y;
               this.statusTF.y = STATUS_TF_Y;
               this.deviderLeft.y = DEVIDERS_ROTATED_Y;
               this.bulletRightBright.y = this.bulletRightDim.y = this.deviderRight.y = this.bulletLeftBright.y = this.bulletLeftDim.y = DEVIDERS_Y;
            }
            else
            {
               App.utils.commons.updateTextFieldSize(this.titleTF,true,true);
               this.titleTF.y = TITLE_TF_Y_BIG;
               this.statusTF.y = STATUS_TF_Y_BIG;
               this.deviderLeft.y = DEVIDERS_ROTATED_Y_BIG;
               this.bulletRightBright.y = this.bulletRightDim.y = this.deviderRight.y = this.bulletLeftBright.y = this.bulletLeftDim.y = DEVIDERS_Y_BIG;
            }
            this.deviderRight.width = this.deviderLeft.width = this.getDeviderWidth();
            this.deviderLeft.x = this.bulletLeftDim.x + this.deviderLeft.width + BULLET_WIDTH + BULLET_GAP | 0;
            this.bulletLeftBright.x = this.deviderLeft.x + BULLET_GAP;
            this.titleTF.x = this.bulletLeftBright.x + TEXT_GAP;
            this.bulletRightBright.x = this.titleTF.x + this.titleTF.textWidth + TEXT_GAP | 0;
            this.deviderRight.x = this.bulletRightBright.x + BULLET_WIDTH + BULLET_GAP;
            this.bulletRightDim.x = this.deviderRight.x + this.deviderRight.width + BULLET_GAP;
         }
      }
      
      override protected function onDispose() : void
      {
         this._tooltipMgr.hide();
         this._tooltipMgr = null;
         this.statusTF.removeEventListener(MouseEvent.MOUSE_OVER,this.onStatusTfMouseOverHandler);
         this.statusTF.removeEventListener(MouseEvent.MOUSE_OUT,this.onStatusTfMouseOutHandler);
         this.statusBg.dispose();
         this.statusBg = null;
         this.titleTF = null;
         this.bulletRightBright = null;
         this.bulletRightDim = null;
         this.deviderRight = null;
         this.bulletLeftBright = null;
         this.bulletLeftDim = null;
         this.deviderLeft = null;
         this.statusTF = null;
         this._statusData = null;
         super.onDispose();
      }
      
      public function setStatus(param1:DAAPIQuestStatusVO) : void
      {
         if(this._statusData != param1 && param1 != null)
         {
            this._statusData = param1;
            invalidateData();
         }
      }
      
      public function setTitle(param1:String) : void
      {
         if(this._title != param1 && param1 != null)
         {
            this._title = param1;
            invalidateData();
         }
      }
      
      private function getDeviderWidth() : int
      {
         return (WIDTH - this.titleTF.textWidth + TEXTFIELD_PADDING - TEXT_GAP * DEVIDERS_COUNT - BULLET_WIDTH * BULLETS_COUNT - BULLET_GAP * BULLETS_COUNT) / DEVIDERS_COUNT | 0;
      }
      
      private function onStatusTfMouseOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
      
      private function onStatusTfMouseOverHandler(param1:MouseEvent) : void
      {
         if(this._statusData && this._statusData.status == MISSIONS_STATES.IS_ON_PAUSE)
         {
            this._tooltipMgr.showComplex(TOOLTIPS.STATISTICS_TAB_QUESTS_STATUS_ONPAUSE);
         }
      }
   }
}
