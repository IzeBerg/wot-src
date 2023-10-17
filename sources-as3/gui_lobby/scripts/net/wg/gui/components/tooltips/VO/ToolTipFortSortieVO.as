package net.wg.gui.components.tooltips.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ToolTipFortSortieVO extends DAAPIDataClass
   {
       
      
      public var titleText:String = "";
      
      public var divisionText:String = "";
      
      public var descriptionText:String = "";
      
      public var hintText:String = "";
      
      public var inBattleText:String = "";
      
      public var isInBattle:Boolean = false;
      
      public function ToolTipFortSortieVO(param1:Object)
      {
         super(param1);
      }
   }
}
