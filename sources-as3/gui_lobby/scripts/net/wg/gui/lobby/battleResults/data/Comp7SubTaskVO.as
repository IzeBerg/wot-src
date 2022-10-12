package net.wg.gui.lobby.battleResults.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class Comp7SubTaskVO extends DAAPIDataClass
   {
       
      
      public var linkage:String = "";
      
      public var title:String = "";
      
      public var descr:String = "";
      
      public var icon:String = "";
      
      public var ratingDiff:String = "";
      
      public var hasProgressBar:Boolean = false;
      
      public var progressBarCurrent:int = 0;
      
      public var progressBarTotal:int = 0;
      
      public var progressBarBegin:int = 0;
      
      public var ratingTotal:String = "";
      
      public function Comp7SubTaskVO(param1:Object)
      {
         super(param1);
      }
   }
}
