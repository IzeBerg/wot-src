package net.wg.gui.lobby.techtree.data.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class VehCompareEntrypointTreeNodeVO extends DAAPIDataClass
   {
       
      
      public var modeAvailable:Boolean = false;
      
      public var cmpBasketFull:Boolean = true;
      
      public function VehCompareEntrypointTreeNodeVO(param1:Object)
      {
         super(param1);
      }
   }
}
