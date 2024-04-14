package net.wg.gui.lobby.fortifications.battleRoom.clanBattle
{
   import flash.display.InteractiveObject;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.FORTIFICATION_ALIASES;
   import net.wg.gui.components.controls.TableRenderer;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.lobby.fortifications.data.battleRoom.clanBattle.ClanBattleRenderListVO;
   import net.wg.gui.lobby.fortifications.interfaces.IClanBattleTimer;
   import net.wg.gui.rally.interfaces.IManualSearchRenderer;
   import scaleform.gfx.TextFieldEx;
   
   public class ClanBattleTableRenderer extends TableRenderer implements IManualSearchRenderer
   {
       
      
      public var battleType:UILoaderAlt;
      
      public var battleName:TextField;
      
      public var battleDirection:TextField;
      
      public var dayOfBattle:TextField;
      
      public var beforeBegins:TextField;
      
      public var timer:IClanBattleTimer;
      
      private var model:ClanBattleRenderListVO = null;
      
      private var isBattleTypeTTShowed:Boolean = false;
      
      public function ClanBattleTableRenderer()
      {
         var _loc2_:InteractiveObject = null;
         super();
         TextFieldEx.setVerticalAlign(this.beforeBegins,TextFieldEx.VALIGN_CENTER);
         TextFieldEx.setVerticalAlign(this.dayOfBattle,TextFieldEx.VALIGN_CENTER);
         var _loc1_:Array = [this.battleName,this.battleDirection,this.dayOfBattle,this.beforeBegins,this.timer];
         for each(_loc2_ in _loc1_)
         {
            _loc2_.mouseEnabled = false;
         }
      }
      
      override public function setData(param1:Object) : void
      {
         if(!param1)
         {
            visible = false;
            return;
         }
         if(!visible)
         {
            visible = true;
         }
         this.model = ClanBattleRenderListVO(param1);
         super.setData(param1);
         if(this.model.battleType == FORTIFICATION_ALIASES.CLAN_BATTLE_DEFENCE)
         {
            this.battleType.source = RES_ICONS.MAPS_ICONS_LIBRARY_FORTIFICATION_DEFENCEFUTURE;
         }
         else if(this.model.battleType == FORTIFICATION_ALIASES.CLAN_BATTLE_OFFENCE)
         {
            this.battleType.source = RES_ICONS.MAPS_ICONS_LIBRARY_FORTIFICATION_OFFENCEFUTURE;
         }
         if(this.model.stateOfBattle == FORTIFICATION_ALIASES.CLAN_BATTLE_BEGINS)
         {
            TextFieldEx.setVerticalAlign(this.beforeBegins,TextFieldEx.VALIGN_TOP);
            this.timer.visible = true;
            this.timer.setData(this.model.timer);
         }
         else
         {
            TextFieldEx.setVerticalAlign(this.beforeBegins,TextFieldEx.VALIGN_CENTER);
            this.timer.visible = false;
         }
         if(this.model.stateOfBattle == FORTIFICATION_ALIASES.CLAN_BATTLE_BATTLE_TOMORROW || this.model.stateOfBattle == FORTIFICATION_ALIASES.CLAN_BATTLE_BATTLE_TODAY)
         {
            doubleClickEnabled = false;
         }
         else
         {
            doubleClickEnabled = true;
         }
         this.battleName.htmlText = this.model.battleName;
         this.battleDirection.htmlText = this.model.battleDirection;
         this.dayOfBattle.htmlText = this.model.dayOfBattle;
         this.beforeBegins.htmlText = this.model.beforeBegins["text"];
      }
      
      public function update(param1:Object) : void
      {
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.MOUSE_MOVE,this.mouseMoveHandler);
         this.battleType.dispose();
         this.battleType = null;
         this.timer = null;
         super.onDispose();
      }
      
      override protected function handleMouseRollOut(param1:MouseEvent) : void
      {
         super.handleMouseRollOut(param1);
         removeEventListener(MouseEvent.MOUSE_MOVE,this.mouseMoveHandler);
         App.toolTipMgr.hide();
         this.isBattleTypeTTShowed = false;
      }
      
      override protected function handleMouseRollOver(param1:MouseEvent) : void
      {
         super.handleMouseRollOver(param1);
         addEventListener(MouseEvent.MOUSE_MOVE,this.mouseMoveHandler);
      }
      
      private function onRollOverLoaderHandler() : String
      {
         var _loc1_:String = Values.EMPTY_STR;
         if(this.model.battleType == FORTIFICATION_ALIASES.CLAN_BATTLE_DEFENCE)
         {
            _loc1_ = TOOLTIPS.FORTIFICATION_FORTCLANBATTLELIST_BATTLETYPEICON_DEFENCE;
         }
         else if(this.model.battleType == FORTIFICATION_ALIASES.CLAN_BATTLE_OFFENCE)
         {
            _loc1_ = TOOLTIPS.FORTIFICATION_FORTCLANBATTLELIST_BATTLETYPEICON_OFFENCE;
         }
         return _loc1_;
      }
      
      private function mouseMoveHandler(param1:MouseEvent) : void
      {
         var _loc2_:Point = new Point(mouseX,mouseY);
         _loc2_ = localToGlobal(_loc2_);
         if(this.battleType.hitTestPoint(_loc2_.x,_loc2_.y))
         {
            if(!this.isBattleTypeTTShowed)
            {
               App.toolTipMgr.show(this.onRollOverLoaderHandler());
               this.isBattleTypeTTShowed = true;
            }
            return;
         }
         App.toolTipMgr.hide();
         this.isBattleTypeTTShowed = false;
      }
   }
}
