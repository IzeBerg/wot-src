package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.BaseDAAPIModule;
   import net.wg.infrastructure.interfaces.IImageUrlProperties;
   import net.wg.infrastructure.interfaces.IStrCaseProperties;
   
   public class UtilsManagerMeta extends BaseDAAPIModule
   {
       
      
      public var getNationNames:Function;
      
      public var getNationIndices:Function;
      
      public var getGUINations:Function;
      
      public var changeStringCasing:Function;
      
      public var mapScaleformToVirtualKey:Function;
      
      public var getCharFromVirtualKey:Function;
      
      public var getAbsoluteUrl:Function;
      
      public var getHtmlIconText:Function;
      
      public var getFirstDayOfWeek:Function;
      
      public var getWeekDayNames:Function;
      
      public var getMonthsNames:Function;
      
      public var intToStringWithPrefixPatern:Function;
      
      public var isTwelveHoursFormat:Function;
      
      public function UtilsManagerMeta()
      {
         super();
      }
      
      public function getNationNamesS() : Array
      {
         App.utils.asserter.assertNotNull(this.getNationNames,"getNationNames" + Errors.CANT_NULL);
         return this.getNationNames();
      }
      
      public function getNationIndicesS() : Object
      {
         App.utils.asserter.assertNotNull(this.getNationIndices,"getNationIndices" + Errors.CANT_NULL);
         return this.getNationIndices();
      }
      
      public function getGUINationsS() : Array
      {
         App.utils.asserter.assertNotNull(this.getGUINations,"getGUINations" + Errors.CANT_NULL);
         return this.getGUINations();
      }
      
      public function changeStringCasingS(param1:String, param2:Boolean, param3:IStrCaseProperties) : String
      {
         App.utils.asserter.assertNotNull(this.changeStringCasing,"changeStringCasing" + Errors.CANT_NULL);
         return this.changeStringCasing(param1,param2,param3);
      }
      
      public function mapScaleformToVirtualKeyS(param1:int) : int
      {
         App.utils.asserter.assertNotNull(this.mapScaleformToVirtualKey,"mapScaleformToVirtualKey" + Errors.CANT_NULL);
         return this.mapScaleformToVirtualKey(param1);
      }
      
      public function getCharFromVirtualKeyS(param1:int) : int
      {
         App.utils.asserter.assertNotNull(this.getCharFromVirtualKey,"getCharFromVirtualKey" + Errors.CANT_NULL);
         return this.getCharFromVirtualKey(param1);
      }
      
      public function getAbsoluteUrlS(param1:String) : String
      {
         App.utils.asserter.assertNotNull(this.getAbsoluteUrl,"getAbsoluteUrl" + Errors.CANT_NULL);
         return this.getAbsoluteUrl(param1);
      }
      
      public function getHtmlIconTextS(param1:IImageUrlProperties) : String
      {
         App.utils.asserter.assertNotNull(this.getHtmlIconText,"getHtmlIconText" + Errors.CANT_NULL);
         return this.getHtmlIconText(param1);
      }
      
      public function getFirstDayOfWeekS() : int
      {
         App.utils.asserter.assertNotNull(this.getFirstDayOfWeek,"getFirstDayOfWeek" + Errors.CANT_NULL);
         return this.getFirstDayOfWeek();
      }
      
      public function getWeekDayNamesS(param1:Boolean = true, param2:Boolean = false, param3:Boolean = false) : Array
      {
         App.utils.asserter.assertNotNull(this.getWeekDayNames,"getWeekDayNames" + Errors.CANT_NULL);
         return this.getWeekDayNames(param1,param2,param3);
      }
      
      public function getMonthsNamesS(param1:Boolean = true, param2:Boolean = false, param3:Boolean = false) : Array
      {
         App.utils.asserter.assertNotNull(this.getMonthsNames,"getMonthsNames" + Errors.CANT_NULL);
         return this.getMonthsNames(param1,param2,param3);
      }
      
      public function intToStringWithPrefixPaternS(param1:int, param2:int, param3:String) : String
      {
         App.utils.asserter.assertNotNull(this.intToStringWithPrefixPatern,"intToStringWithPrefixPatern" + Errors.CANT_NULL);
         return this.intToStringWithPrefixPatern(param1,param2,param3);
      }
      
      public function isTwelveHoursFormatS() : Boolean
      {
         App.utils.asserter.assertNotNull(this.isTwelveHoursFormat,"isTwelveHoursFormat" + Errors.CANT_NULL);
         return this.isTwelveHoursFormat();
      }
   }
}
