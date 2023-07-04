package net.wg.gui.lobby.vehicleCustomization.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.carousels.data.CheckBoxRendererVO;
   import net.wg.gui.components.controls.VO.SimpleRendererVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   
   public class FiltersPopoverVO extends DAAPIDataClass
   {
      
      private static const GROUP_TYPE:String = "groupType";
      
      private static const FILTER_BTNS:String = "filterBtns";
      
      private static const FORMS_BTNS:String = "formsBtns";
      
      private static const ADDITIONAL_CHECKBOX_DATA:String = "additionalCheckBoxData";
       
      
      public var lblTitle:String = "";
      
      public var lblGroups:String = "";
      
      public var lblShowOnlyFilters:String = "";
      
      public var lblAdditional:String = "";
      
      public var formsBtnsLbl:String = "";
      
      public var btnDefault:String = "";
      
      public var bonusTypeDisableTooltip:String = "";
      
      public var groupTypeSelectedIndex:int = -1;
      
      public var btnDefaultTooltip:String = "";
      
      public var additionalEnabled:Boolean = false;
      
      public var additionalCheckBoxData:CheckBoxRendererVO = null;
      
      public var groupType:Vector.<String> = null;
      
      public var filterBtns:DataProvider = null;
      
      public var formsBtns:DataProvider = null;
      
      public function FiltersPopoverVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Object = null;
         var _loc4_:String = null;
         if(param1 == GROUP_TYPE)
         {
            this.groupType = new Vector.<String>();
            for each(_loc4_ in param2)
            {
               this.groupType.push(_loc4_);
            }
            return false;
         }
         if(param1 == FILTER_BTNS)
         {
            this.filterBtns = new DataProvider();
            for each(_loc3_ in param2)
            {
               this.filterBtns.push(new SimpleRendererVO(_loc3_));
            }
            return false;
         }
         if(param1 == FORMS_BTNS)
         {
            this.formsBtns = new DataProvider();
            for each(_loc3_ in param2)
            {
               this.formsBtns.push(new SimpleRendererVO(_loc3_));
            }
            return false;
         }
         if(param1 == ADDITIONAL_CHECKBOX_DATA)
         {
            this.additionalCheckBoxData = new CheckBoxRendererVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         if(this.groupType != null)
         {
            this.groupType.splice(0,this.groupType.length);
            this.groupType = null;
         }
         if(this.filterBtns != null)
         {
            for each(_loc1_ in this.filterBtns)
            {
               _loc1_.dispose();
            }
            this.filterBtns.cleanUp();
            this.filterBtns = null;
         }
         if(this.additionalCheckBoxData)
         {
            this.additionalCheckBoxData.dispose();
            this.additionalCheckBoxData = null;
         }
         super.onDispose();
      }
   }
}
