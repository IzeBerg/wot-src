package net.wg.gui.lobby.linkedSet.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.advanced.vo.ProgressBarAnimVO;
   
   public class LinkedSetDetailsOverlayVO extends DAAPIDataClass
   {
      
      private static const AWARDS:String = "awards";
      
      private static const PROGRESS_BAR_DATA:String = "progressBarData";
       
      
      public var title:String = "";
      
      public var status:String = "";
      
      public var info:String = "";
      
      public var task:String = "";
      
      public var description:String = "";
      
      public var progressBarData:ProgressBarAnimVO = null;
      
      public var awards:Vector.<LinkedSetAwardVO>;
      
      public var btnStartLabel:String = "";
      
      public var eventID:String = "";
      
      public var isBackOverlay:Boolean = false;
      
      public var isMovie:Boolean = false;
      
      public var isProgressBar:Boolean = false;
      
      public var back:String = "";
      
      public function LinkedSetDetailsOverlayVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Object = null;
         if(param1 == AWARDS)
         {
            this.awards = new Vector.<LinkedSetAwardVO>(0);
            for each(_loc3_ in param2)
            {
               this.awards.push(new LinkedSetAwardVO(_loc3_));
            }
            return false;
         }
         if(param1 == PROGRESS_BAR_DATA)
         {
            this.progressBarData = new ProgressBarAnimVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:LinkedSetAwardVO = null;
         if(this.progressBarData)
         {
            this.progressBarData.dispose();
            this.progressBarData = null;
         }
         for each(_loc1_ in this.awards)
         {
            _loc1_.dispose();
         }
         this.awards.length = 0;
         this.awards = null;
         super.onDispose();
      }
   }
}
