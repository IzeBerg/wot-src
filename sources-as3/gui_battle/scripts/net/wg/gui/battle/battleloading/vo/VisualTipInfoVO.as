package net.wg.gui.battle.battleloading.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class VisualTipInfoVO extends DAAPIDataClass
   {
       
      
      public var settingID:String = "";
      
      public var tipIcon:String = "";
      
      public var arenaTypeID:int = -1;
      
      public var minimapTeam:int = -1;
      
      public var showMinimap:Boolean;
      
      public var leftTeamTitleLeft:int;
      
      public var rightTeamTitleLeft:int;
      
      public var tipTitleTop:int;
      
      public var tipBodyTop:int;
      
      public var showTableBackground:Boolean;
      
      public var showTipsBackground:Boolean;
      
      public function VisualTipInfoVO(param1:Object)
      {
         super(param1);
      }
   }
}
