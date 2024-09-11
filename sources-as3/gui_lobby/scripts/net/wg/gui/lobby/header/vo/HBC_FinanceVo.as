package net.wg.gui.lobby.header.vo
{
   public class HBC_FinanceVo extends HBC_AbstractVO
   {
       
      
      public var money:String = "";
      
      public var btnDoText:String = "";
      
      public var isDiscountEnabled:Boolean = false;
      
      public var playDiscountAnimation:Boolean = false;
      
      public var isHasAction:Boolean = false;
      
      public var icon:String = "empty";
      
      public var isNew:Boolean = false;
      
      public var isAnimationRequired:Boolean = false;
      
      public var shortMoneyValue:String = "";
      
      public function HBC_FinanceVo(param1:Object = null)
      {
         super(param1);
      }
   }
}
