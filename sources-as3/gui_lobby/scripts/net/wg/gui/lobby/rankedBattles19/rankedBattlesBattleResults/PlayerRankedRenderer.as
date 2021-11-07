package net.wg.gui.lobby.rankedBattles19.rankedBattlesBattleResults
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.VO.UserVO;
   import net.wg.data.constants.UserTags;
   import net.wg.gui.components.controls.UserNameField;
   import net.wg.gui.lobby.rankedBattles19.data.PlayerRankRendererVO;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.controls.ListItemRenderer;
   
   public class PlayerRankedRenderer extends ListItemRenderer
   {
      
      public static const RENDERER_HEIGHT:int = 28;
      
      public static const HUGE_RENDERER_HEIGHT:int = 32;
      
      private static const STATE_BLINK:String = "show";
      
      private static const STANDOFF_HUGE_OFFSET_Y:int = 2;
      
      private static const FONT_SIZE_COMPACT:int = 14;
      
      private static const FONT_SIZE_INCOMPACT:int = 16;
       
      
      public var selectBackground:MovieClip = null;
      
      public var nickName:UserNameField = null;
      
      public var standoff:MovieClip = null;
      
      public var points:TextField = null;
      
      public var wave:MovieClip = null;
      
      private var _selectedActive:Boolean = false;
      
      private var _standoffVisible:Boolean = false;
      
      private var _isCompact:Boolean = false;
      
      private var _standoffY:int = -1;
      
      private var _standoffHugeY:int = -1;
      
      private var _tooltipMgr:ITooltipMgr = null;
      
      private var _dataVo:PlayerRankRendererVO = null;
      
      private var _tooltipNickName:String = "";
      
      public function PlayerRankedRenderer()
      {
         super();
         this._tooltipMgr = App.toolTipMgr;
      }
      
      override public function setData(param1:Object) : void
      {
         this._dataVo = PlayerRankRendererVO(param1);
         var _loc2_:int = this._dataVo.standoff;
         this._standoffVisible = Boolean(_loc2_);
         this._selectedActive = this._dataVo.selected;
         this.selectBackground.visible = this._selectedActive;
         this.standoff.visible = this._standoffVisible;
         if(this._standoffVisible)
         {
            this.standoff.gotoAndStop(_loc2_);
         }
         this.updateTexts();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._standoffY = this.standoff.y;
         this._standoffHugeY = this._standoffY + STANDOFF_HUGE_OFFSET_Y;
         this.nickName.addEventListener(MouseEvent.MOUSE_OVER,this.onNickNameMouseOverHandler);
         this.nickName.addEventListener(MouseEvent.MOUSE_OUT,this.onNickNameMouseOutHandler);
         this.points.mouseEnabled = false;
         mouseEnabled = false;
         mouseChildren = true;
      }
      
      override protected function onDispose() : void
      {
         this.nickName.removeEventListener(MouseEvent.MOUSE_OVER,this.onNickNameMouseOverHandler);
         this.nickName.removeEventListener(MouseEvent.MOUSE_OUT,this.onNickNameMouseOutHandler);
         this._dataVo = null;
         this.selectBackground = null;
         this.nickName = null;
         this.standoff = null;
         this.points = null;
         _owner = null;
         this.wave = null;
         this._tooltipMgr = null;
         super.onDispose();
      }
      
      public function blink() : void
      {
         this.wave.gotoAndPlay(STATE_BLINK);
      }
      
      public function setCompact(param1:Boolean) : void
      {
         if(this._isCompact == param1)
         {
            return;
         }
         this._isCompact = param1;
         this.selectBackground.height = !!param1 ? Number(RENDERER_HEIGHT) : Number(HUGE_RENDERER_HEIGHT);
         this.standoff.y = !!param1 ? Number(this._standoffY) : Number(this._standoffHugeY);
         this.updateTexts();
      }
      
      private function updateTexts() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:Boolean = false;
         if(this._dataVo)
         {
            if(this._isCompact)
            {
               _loc1_ = this._dataVo.nickName;
               _loc2_ = this._dataVo.fakeName;
               _loc3_ = FONT_SIZE_COMPACT;
               this.points.htmlText = this._dataVo.points;
            }
            else
            {
               _loc1_ = this._dataVo.nickNameHuge;
               _loc2_ = this._dataVo.fakeNameHuge;
               _loc3_ = FONT_SIZE_INCOMPACT;
               this.points.htmlText = this._dataVo.pointsHuge;
            }
            this.nickName.userVO = new UserVO({
               "userName":_loc1_,
               "fakeName":_loc2_,
               "fullName":_loc1_,
               "tags":this._dataVo.tags
            });
            this.nickName.textSize = _loc3_;
            _loc4_ = UserTags.isCurrentPlayer(this._dataVo.tags);
            this.nickName.useFakeName = !_loc4_;
            this.nickName.showAnonymizerIcon = _loc4_;
         }
      }
      
      private function showTooltipFullName(param1:String) : void
      {
         if(StringUtils.isNotEmpty(param1))
         {
            this._tooltipMgr.show(param1);
         }
      }
      
      override public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         this.selectBackground.visible = param1;
      }
      
      public function get selectedActive() : Boolean
      {
         return this._selectedActive;
      }
      
      public function get standoffVisible() : Boolean
      {
         return this._standoffVisible;
      }
      
      private function onNickNameMouseOverHandler(param1:MouseEvent) : void
      {
         this.showTooltipFullName(this._tooltipNickName);
      }
      
      private function onNickNameMouseOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
   }
}
