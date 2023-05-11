package net.wg.gui.lobby.battleResults.progressReport
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class BattleResultUnlockDogTagVO extends DAAPIDataClass
   {
       
      
      public var dogTagType:String = "";
      
      public var imageSrc:String = "";
      
      public var title:String = "";
      
      public var description:String = "";
      
      public var unlockType:String = "";
      
      public var componentId:int = -1;
      
      public function BattleResultUnlockDogTagVO(param1:Object)
      {
         super(param1);
      }
   }
}
