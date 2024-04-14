package net.wg.gui.lobby.eventBoards.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class BattleExperienceBlockVO extends DAAPIDataClass
   {
       
      
      public var experienceValue:String = "";
      
      public var experience:String = "";
      
      public var position:String = "";
      
      public var battleValue:String = "";
      
      public var battle:String = "";
      
      public var experienceIcon:String = "";
      
      public var battleIcon:String = "";
      
      public var ribbon:int = -1;
      
      public var experienceTooltip:String = "";
      
      public var positionTooltip:String = "";
      
      public var battleTooltip:String = "";
      
      public function BattleExperienceBlockVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
