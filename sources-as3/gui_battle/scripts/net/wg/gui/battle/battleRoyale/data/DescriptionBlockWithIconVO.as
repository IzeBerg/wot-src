package net.wg.gui.battle.battleRoyale.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class DescriptionBlockWithIconVO extends DAAPIDataClass
   {
       
      
      public var icon:String = "";
      
      public var description:String = "";
      
      public var blendMode:String = "";
      
      public function DescriptionBlockWithIconVO(param1:Object)
      {
         super(param1);
      }
   }
}
