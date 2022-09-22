package net.wg.gui.battle.eventBattle.views.eventPlayersPanel.comps
{
   import flash.text.TextField;
   import net.wg.gui.battle.components.BattleUIComponent;
   import scaleform.gfx.TextFieldEx;
   
   public class EventBotListInfo extends BattleUIComponent
   {
      
      private static const FRAME_LABEL_ALLY:String = "ally";
      
      private static const FRAME_LABEL_ENEMY:String = "enemy";
       
      
      public var titleTF:TextField = null;
      
      public var indexTF:TextField = null;
      
      public function EventBotListInfo()
      {
         super();
         TextFieldEx.setNoTranslate(this.titleTF,true);
         TextFieldEx.setNoTranslate(this.indexTF,true);
      }
      
      override protected function onDispose() : void
      {
         this.titleTF = null;
         this.indexTF = null;
         super.onDispose();
      }
      
      public function setData(param1:int, param2:Boolean) : void
      {
         gotoAndStop(!!param2 ? FRAME_LABEL_ALLY : FRAME_LABEL_ENEMY);
         var _loc3_:String = String(param1);
         this.titleTF.text = App.utils.locale.makeString(EVENT.PLAYERSPANEL_CAMPLABEL,{"index":_loc3_});
         this.indexTF.text = _loc3_;
      }
   }
}
