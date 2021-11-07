package net.wg.gui.components.tooltips.VO
{
   import net.wg.data.constants.Values;
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ToolTipTankClassVO extends DAAPIDataClass
   {
       
      
      public var name:String = "";
      
      public var value:Number = 0;
      
      public var localizedValue:String = "";
      
      public var section:String = "";
      
      public var type:String = "";
      
      public var records:Object = null;
      
      public var newRecord:String = "";
      
      public var oldRecordOn:String = "";
      
      public var oldRecordLevel:String = "";
      
      public var historyDescr:String = "";
      
      public var stats:Object = null;
      
      public var params:Array = null;
      
      public var descr:String = "";
      
      public var isInDossier:Boolean = false;
      
      public var icon:String = "";
      
      public var condition:String = "";
      
      public var inactive:Boolean = false;
      
      public var crystalAwards:Object = null;
      
      public function ToolTipTankClassVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == "records")
         {
            this.records = param2;
            this.newRecord = this.records.hasOwnProperty("current") && this.records.current ? this.records.current : Values.EMPTY_STR;
            if(this.records.hasOwnProperty("nearest") && this.records.nearest is Array && this.records.nearest[0] is Array && this.records.nearest[0].length >= 2)
            {
               this.oldRecordOn = this.records.nearest[0][0];
               this.oldRecordLevel = this.records.nearest[0][1].toString(10);
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         this.records = null;
         this.stats = null;
         App.utils.data.cleanupDynamicObject(this.crystalAwards);
         this.crystalAwards = null;
         super.onDispose();
      }
   }
}
