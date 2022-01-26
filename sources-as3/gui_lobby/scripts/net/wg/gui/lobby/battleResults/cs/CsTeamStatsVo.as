package net.wg.gui.lobby.battleResults.cs
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class CsTeamStatsVo extends DAAPIDataClass
   {
       
      
      public var teamDBID:Number = -1;
      
      public var resultShortStr:String = "";
      
      public var status:String = "";
      
      public var ladder:String = "";
      
      public var points:Number = 0;
      
      public var pointsDif:Number = 0;
      
      public var pointsDifStr:String = "";
      
      public function CsTeamStatsVo(param1:Object)
      {
         super(param1);
      }
   }
}
