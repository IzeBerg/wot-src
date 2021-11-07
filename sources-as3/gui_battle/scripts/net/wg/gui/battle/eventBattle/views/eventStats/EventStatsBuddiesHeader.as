package net.wg.gui.battle.eventBattle.views.eventStats
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class EventStatsBuddiesHeader extends MovieClip implements IDisposable
   {
       
      
      public var teamTF:TextField = null;
      
      public var platoon:MovieClip = null;
      
      public var tank:MovieClip = null;
      
      public var matter:MovieClip = null;
      
      public var kills:MovieClip = null;
      
      public var damage:MovieClip = null;
      
      public var blocked:MovieClip = null;
      
      private var _tooltipMgr:ITooltipMgr;
      
      public function EventStatsBuddiesHeader()
      {
         this._tooltipMgr = App.toolTipMgr;
         super();
         this.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         this.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
         this.mouseChildren = true;
         this.teamTF.text = EVENT.RESULTSCREEN_TEAMMATES;
      }
      
      public final function dispose() : void
      {
         this.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         this.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
         this.teamTF = null;
         this.platoon = null;
         this.tank = null;
         this.matter = null;
         this.kills = null;
         this.damage = null;
         this.blocked = null;
         this._tooltipMgr = null;
      }
      
      private function onMouseOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = Values.EMPTY_STR;
         switch(param1.target)
         {
            case this.teamTF:
               _loc2_ = CLANS.CLANINVITESWINDOW_TABLE_USERNAME;
               break;
            case this.platoon:
               _loc2_ = EVENT.RESULTSCREEN_TOOLTIP_PLATOONTOOLTIP_HEADER;
               break;
            case this.tank:
               _loc2_ = EVENT.RESULTSCREEN_TOOLTIP_TANKTOOLTIP_HEADER;
               break;
            case this.matter:
               _loc2_ = EVENT.RESULTSCREEN_TOOLTIPS_MATTERHEADER;
               break;
            case this.kills:
               _loc2_ = BATTLE_RESULTS.TEAM_FRAGHEADER_HEADER;
               break;
            case this.damage:
               _loc2_ = BATTLE_RESULTS.TEAM_DAMAGEHEADER_HEADER;
               break;
            case this.blocked:
               _loc2_ = EVENT.RESULTSCREEN_TOOLTIP_DAMAGEBLOCKEDBYARMOR_HEADER;
         }
         if(StringUtils.isNotEmpty(_loc2_))
         {
            this._tooltipMgr.show(_loc2_);
         }
      }
      
      private function onMouseOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
   }
}
