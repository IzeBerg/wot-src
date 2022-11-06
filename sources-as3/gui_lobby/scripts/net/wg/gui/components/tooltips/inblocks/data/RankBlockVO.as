package net.wg.gui.components.tooltips.inblocks.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class RankBlockVO extends DAAPIDataClass
   {
       
      
      public var isEnabled:Boolean = false;
      
      public var rankImage:String = "";
      
      public var shieldImage:String = "";
      
      public var plateImage:String = "";
      
      public function RankBlockVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
