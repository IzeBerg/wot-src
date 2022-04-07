package net.wg.gui.lobby.battleResults.cs
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.managers.IToolTipParams;
   import net.wg.data.managers.impl.ToolTipParams;
   import net.wg.gui.components.advanced.ClanEmblem;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.TextFieldShort;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.gui.lobby.battleResults.IEmblemLoadedDelegate;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class CsTeamStats extends UIComponentEx implements IEmblemLoadedDelegate
   {
       
      
      public var teamName:TextFieldShort = null;
      
      public var teamEmblem:ClanEmblem = null;
      
      public var toCard:SoundButtonEx = null;
      
      public var ladder:UILoaderAlt = null;
      
      public var statusTF:TextField = null;
      
      public var pointsNameTF:TextField = null;
      
      public var pointsDots:Sprite = null;
      
      public var pointsTF:TextField = null;
      
      public var pointsDifTF:TextField = null;
      
      public var bg:CsTeamStatsBg = null;
      
      private var _data:CsTeamStatsVo = null;
      
      private const DOTS_MARGIN_LEFT:Number = 4;
      
      private const DOTS_MARGIN_RIGHT:Number = 2;
      
      private const POINTS_DIF_MARGIN:Number = 6;
      
      private const TEAM_NAME_MARGIN:Number = 10;
      
      public function CsTeamStats()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.teamEmblem.visible = false;
         this.pointsNameTF.text = BATTLE_RESULTS.CYBERSPORT_POINTS;
         this.pointsDots.x = this.pointsNameTF.x + this.pointsNameTF.textWidth + this.DOTS_MARGIN_LEFT ^ 0;
         this.toCard.label = BATTLE_RESULTS.CYBERSPORT_BTNTOTEAMPROFILE;
         this.teamEmblem.loader.addEventListener(UILoaderEvent.COMPLETE,this.onEmblemLoadedHandler);
         this.teamEmblem.loader.addEventListener(UILoaderEvent.IOERROR,this.onEmblemLoadErrorHandler);
         this.ladder.addEventListener(MouseEvent.MOUSE_OVER,this.onLadderOverHandler);
         this.ladder.addEventListener(MouseEvent.MOUSE_OUT,this.onHideTooltipHandler);
         this.ladder.addEventListener(MouseEvent.CLICK,this.onHideTooltipHandler);
         this.pointsTF.addEventListener(MouseEvent.MOUSE_OVER,this.onPointsOverHandler);
         this.pointsTF.addEventListener(MouseEvent.MOUSE_OUT,this.onHideTooltipHandler);
         this.pointsTF.addEventListener(MouseEvent.CLICK,this.onHideTooltipHandler);
      }
      
      override protected function onDispose() : void
      {
         this.teamName.dispose();
         this.teamName = null;
         this.teamEmblem.loader.removeEventListener(UILoaderEvent.COMPLETE,this.onEmblemLoadedHandler);
         this.teamEmblem.loader.removeEventListener(UILoaderEvent.IOERROR,this.onEmblemLoadErrorHandler);
         this.ladder.removeEventListener(MouseEvent.MOUSE_OVER,this.onLadderOverHandler);
         this.ladder.removeEventListener(MouseEvent.MOUSE_OUT,this.onHideTooltipHandler);
         this.ladder.removeEventListener(MouseEvent.CLICK,this.onHideTooltipHandler);
         this.teamEmblem.dispose();
         this.teamEmblem = null;
         this.toCard.removeEventListener(ButtonEvent.CLICK,this.toCardClickHandler);
         this.toCard.dispose();
         this.toCard = null;
         this.ladder.dispose();
         this.ladder = null;
         this.bg.dispose();
         this.bg = null;
         this.pointsDots = null;
         this.statusTF = null;
         this.pointsNameTF = null;
         this.pointsTF.removeEventListener(MouseEvent.MOUSE_OVER,this.onPointsOverHandler);
         this.pointsTF.removeEventListener(MouseEvent.MOUSE_OUT,this.onHideTooltipHandler);
         this.pointsTF.removeEventListener(MouseEvent.CLICK,this.onHideTooltipHandler);
         this.pointsTF = null;
         this.pointsDifTF.removeEventListener(MouseEvent.MOUSE_OVER,this.onDifPointsOverHandler);
         this.pointsDifTF.removeEventListener(MouseEvent.MOUSE_OUT,this.onHideTooltipHandler);
         this.pointsDifTF.removeEventListener(MouseEvent.CLICK,this.onHideTooltipHandler);
         this.pointsDifTF = null;
         if(this._data)
         {
            this._data.dispose();
            this._data = null;
         }
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA) && this._data)
         {
            this.updateData();
         }
      }
      
      public function setData(param1:Object) : void
      {
         this._data = new CsTeamStatsVo(param1);
         if(this._data && !this.toCard.hasEventListener(ButtonEvent.CLICK))
         {
            this.toCard.addEventListener(ButtonEvent.CLICK,this.toCardClickHandler);
         }
         dispatchEvent(new CsTeamEmblemEvent(CsTeamEmblemEvent.TEAM_EMBLEM_REQUEST,true,false,this._data.teamDBID,this.name,this));
         invalidateData();
      }
      
      private function updateData() : void
      {
         this.ladder.source = this._data.ladder;
         this.statusTF.htmlText = this._data.status;
         this.pointsTF.x = this.pointsDots.x + this.pointsDots.width + this.DOTS_MARGIN_RIGHT ^ 0;
         this.pointsTF.text = this._data.points.toString();
         this.pointsTF.width = this.pointsTF.textWidth + this.POINTS_DIF_MARGIN ^ 0;
         if(this._data.pointsDif != 0)
         {
            this.pointsDifTF.x = this.pointsTF.x + this.pointsTF.width;
            this.pointsDifTF.htmlText = this._data.pointsDifStr;
            this.pointsDifTF.addEventListener(MouseEvent.MOUSE_OVER,this.onDifPointsOverHandler);
            this.pointsDifTF.addEventListener(MouseEvent.MOUSE_OUT,this.onHideTooltipHandler);
            this.pointsDifTF.addEventListener(MouseEvent.CLICK,this.onHideTooltipHandler);
         }
         else
         {
            this.pointsDifTF.visible = false;
         }
         this.bg.status = this._data.resultShortStr;
      }
      
      public function onEmblemLoaded(param1:String, param2:String, param3:String) : void
      {
         this.teamName.label = param3;
         this.teamEmblem.visible = false;
         this.teamEmblem.setImage(param2);
      }
      
      private function hideTooltip() : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onEmblemLoadedHandler(param1:UILoaderEvent) : void
      {
         this.teamName.x = this.teamEmblem.x + this.teamEmblem.width + this.TEAM_NAME_MARGIN;
         this.teamEmblem.visible = true;
      }
      
      private function onEmblemLoadErrorHandler(param1:UILoaderEvent) : void
      {
      }
      
      private function toCardClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new CsTeamEvent(CsTeamEvent.TO_TEAM_CARD_CLICK,true,false,this._data.teamDBID));
      }
      
      private function onLadderOverHandler(param1:MouseEvent) : void
      {
      }
      
      private function onPointsOverHandler(param1:MouseEvent) : void
      {
      }
      
      private function onDifPointsOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:IToolTipParams = new ToolTipParams({},{"dif":this._data.pointsDifStr});
         if(this._data.pointsDif > 0)
         {
            App.toolTipMgr.showComplexWithParams(TOOLTIPS.BATTLERESULTS_CYBERSPORT_POINTS_WIN,_loc2_);
         }
         else
         {
            App.toolTipMgr.showComplexWithParams(TOOLTIPS.BATTLERESULTS_CYBERSPORT_POINTS_LOSE,_loc2_);
         }
      }
      
      private function onHideTooltipHandler(param1:MouseEvent) : void
      {
         this.hideTooltip();
      }
   }
}
