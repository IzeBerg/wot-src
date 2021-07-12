package net.wg.gui.lobby.rankedBattles19.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class RewardsLeagueRendererVO extends DAAPIDataClass
   {
       
      
      public var leagueID:int = 0;
      
      public var styleID:int = 0;
      
      public var title:String = "";
      
      public var description:String = "";
      
      public var isCurrent:Boolean = false;
      
      public var isSpecial:Boolean = false;
      
      public var specialAlias:String = "";
      
      public var specialArgs:Array = null;
      
      public function RewardsLeagueRendererVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         if(this.specialArgs)
         {
            this.specialArgs.splice(0,this.specialArgs.length);
            this.specialArgs = null;
         }
         super.onDispose();
      }
   }
}
