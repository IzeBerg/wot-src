package net.wg.gui.lobby.tankman.crewSkins.model
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class CrewSkinVO extends DAAPIDataClass
   {
       
      
      public var id:int = 0;
      
      public var fullName:String = "";
      
      public var description:String = "";
      
      public var rarity:int = 0;
      
      public var nationFlagIconID:String = "";
      
      public var roleIconID:String = "";
      
      public var iconID:String = "";
      
      public var freeCount:int = 0;
      
      public var maxCount:int = 0;
      
      public var useCount:int = 0;
      
      public var historical:Boolean = false;
      
      public var isEquip:Boolean = false;
      
      public var isNew:Boolean = false;
      
      public var soundSetID:String = "";
      
      public var soundSetName:String = "";
      
      public var soundSetIsAvailable:Boolean = false;
      
      public var isAvailable:Boolean = false;
      
      public var notAvailableMessage:String = "";
      
      public function CrewSkinVO(param1:Object)
      {
         super(param1);
      }
   }
}
