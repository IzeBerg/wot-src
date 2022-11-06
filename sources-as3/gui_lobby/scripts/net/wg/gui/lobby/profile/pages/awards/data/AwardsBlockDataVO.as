package net.wg.gui.lobby.profile.pages.awards.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class AwardsBlockDataVO extends DAAPIDataClass
   {
       
      
      public var label:String;
      
      public var awardsData:Array;
      
      public function AwardsBlockDataVO(param1:Object)
      {
         super(param1);
      }
   }
}
