package net.wg.gui.battle.pveBase.views.secondaryObjectives.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class PveObjectVO extends DAAPIDataClass
   {
       
      
      public var id:String = "";
      
      public var icon:String = "";
      
      public var isTimerEnable:Boolean = false;
      
      public var title:String = "";
      
      public var description:String = "";
      
      public var isVisibleProgressBar:Boolean = false;
      
      public var progressBarValue:int = 0;
      
      public function PveObjectVO(param1:Object)
      {
         super(param1);
      }
   }
}
