package net.wg.gui.lobby.profile.pages.formations.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class PreviousTeamsItemVO extends DAAPIDataClass
   {
       
      
      public var teamId:int = -1;
      
      public var name:String = "";
      
      public var dates:String = "";
      
      public var games:int = 0;
      
      public var wins:int = 0;
      
      public var losses:int = 0;
      
      public var draws:int = 0;
      
      public var showLink:Boolean = false;
      
      public function PreviousTeamsItemVO(param1:Object)
      {
         super(param1);
      }
   }
}
