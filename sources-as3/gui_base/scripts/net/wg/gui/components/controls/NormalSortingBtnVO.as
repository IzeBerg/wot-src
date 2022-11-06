package net.wg.gui.components.controls
{
   import net.wg.gui.components.advanced.SortingButtonVO;
   
   public class NormalSortingBtnVO extends SortingButtonVO
   {
       
      
      public var showSeparator:Boolean = true;
      
      public var showDisabledState:Boolean = false;
      
      public var textAlign:String = "center";
      
      public var verticalTextAlign:String = "bottom";
      
      public var toolTipSpecialType:String = "";
      
      public function NormalSortingBtnVO(param1:Object)
      {
         super(param1);
      }
   }
}
