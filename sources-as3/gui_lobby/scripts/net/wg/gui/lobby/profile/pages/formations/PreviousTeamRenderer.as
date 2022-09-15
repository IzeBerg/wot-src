package net.wg.gui.lobby.profile.pages.formations
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Values;
   import net.wg.data.managers.IToolTipParams;
   import net.wg.data.managers.impl.ToolTipParams;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.TableRenderer;
   import net.wg.gui.lobby.profile.pages.formations.data.PreviousTeamsItemVO;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class PreviousTeamRenderer extends TableRenderer
   {
      
      private static const TOOLTIP_OFFSET:int = 10;
       
      
      public var dates:TextField;
      
      public var battles:TextField;
      
      public var team:TextField;
      
      public var link:SoundButtonEx;
      
      private var _teamId:int = -1;
      
      private var _tooltipParams:IToolTipParams;
      
      public function PreviousTeamRenderer()
      {
         super();
         this._tooltipParams = new ToolTipParams({},{},null);
         this.link.addEventListener(ButtonEvent.CLICK,this.onLinkClick);
         this.link.tooltip = PROFILE.SECTION_FORMATIONS_TOOLTIP_TEAM_LINK;
         this.battles.addEventListener(MouseEvent.ROLL_OVER,this.onBattlesRollOver);
         this.battles.addEventListener(MouseEvent.ROLL_OUT,this.onBattlesRollOut);
      }
      
      override public function setData(param1:Object) : void
      {
         var _loc2_:PreviousTeamsItemVO = null;
         super.setData(param1);
         if(param1 != null)
         {
            _loc2_ = param1 as PreviousTeamsItemVO;
            App.utils.asserter.assertNotNull(_loc2_,"itemData" + Errors.CANT_NULL);
            this._tooltipParams.body.wins = _loc2_.wins.toString();
            this._tooltipParams.body.losses = _loc2_.losses.toString();
            this._tooltipParams.body.draws = _loc2_.draws.toString();
         }
         invalidateData();
      }
      
      override protected function draw() : void
      {
         var _loc1_:PreviousTeamsItemVO = null;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            _loc1_ = data as PreviousTeamsItemVO;
            if(_loc1_ != null)
            {
               this._teamId = _loc1_.teamId;
               this.dates.text = _loc1_.dates;
               this.battles.text = _loc1_.games.toString();
               App.utils.commons.truncateTextFieldText(this.team,_loc1_.name);
               this.link.visible = _loc1_.showLink;
               if(_loc1_.showLink)
               {
                  App.utils.commons.moveDsiplObjToEndOfText(this.link,this.team,TOOLTIP_OFFSET);
               }
            }
            visible = _loc1_ != null;
         }
      }
      
      override protected function onDispose() : void
      {
         this.dates = null;
         this.battles.removeEventListener(MouseEvent.ROLL_OVER,this.onBattlesRollOver);
         this.battles.removeEventListener(MouseEvent.ROLL_OUT,this.onBattlesRollOut);
         this.battles = null;
         this.team = null;
         this.link.removeEventListener(ButtonEvent.CLICK,this.onLinkClick);
         this.link.dispose();
         this.link = null;
         if(this._tooltipParams != null)
         {
            this._tooltipParams.dispose();
            this._tooltipParams = null;
         }
         super.onDispose();
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = true;
         mouseChildren = true;
      }
      
      private function onBattlesRollOut(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onBattlesRollOver(param1:MouseEvent) : void
      {
         App.toolTipMgr.showComplexWithParams(PROFILE.SECTION_FORMATIONS_TOOLTIP_TEAM_SEASONBATTLES,this._tooltipParams);
      }
      
      private function onLinkClick(param1:ButtonEvent) : void
      {
         if(Values.DEFAULT_INT != this._teamId)
         {
            dispatchEvent(new ShowTeamEvent(this._teamId));
         }
      }
   }
}
