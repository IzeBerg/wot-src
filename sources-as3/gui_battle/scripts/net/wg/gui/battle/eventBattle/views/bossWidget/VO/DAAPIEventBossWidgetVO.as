package net.wg.gui.battle.eventBattle.views.bossWidget.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class DAAPIEventBossWidgetVO extends DAAPIDataClass
   {
       
      
      public var playerName:String = "";
      
      public var playerFakeName:String = "";
      
      public var playerFullName:String = "";
      
      public var clanAbbrev:String = "";
      
      public var hpMax:int = 0;
      
      public var hpCurrent:int = 0;
      
      public var isPlayer:Boolean = false;
      
      public var isSpecial:Boolean = false;
      
      public var kills:int = 0;
      
      public var region:String = "";
      
      public function DAAPIEventBossWidgetVO(param1:Object = null)
      {
         super(param1);
      }
      
      public function get isAnonymized() : Boolean
      {
         return this.playerFakeName && this.playerFakeName != this.playerName;
      }
   }
}
