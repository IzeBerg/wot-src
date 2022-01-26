package net.wg.gui.components.tooltips.VO
{
   import net.wg.data.constants.Values;
   import net.wg.gui.components.tooltips.helpers.Utils;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class AchievementVO implements IDisposable
   {
      
      private static const BR:String = "<br/>";
      
      private static const TEXT_FONT_NAME:String = "$TextFont";
      
      private static const TEXT_FONT_SIZE:int = 12;
       
      
      public var aName:String = null;
      
      public var description:String = null;
      
      public var condition:String = null;
      
      public var inactive:Boolean = false;
      
      public var historyDescr:String = null;
      
      public var section:String = null;
      
      public var type:String = null;
      
      public var value:Number = NaN;
      
      public var localizedValue:String = "";
      
      public var icon:String = null;
      
      public var showCondSeparator:Boolean = false;
      
      public var params:Array = null;
      
      public var stats:Object = null;
      
      public var vehicles:Array = null;
      
      public var vehiclesLeft:Number = 0;
      
      public var isInDossier:Boolean = false;
      
      public var classParams:Array = null;
      
      public var achievedOn:String = null;
      
      public var closeToRecord:Array = null;
      
      public var rewardsHeader:String = "";
      
      public var rewardsLabels:Array = null;
      
      public var rewardsValues:Array = null;
      
      public var hasReward:Boolean = false;
      
      public function AchievementVO(param1:Object)
      {
         super();
         this.parsHash(param1);
      }
      
      public final function dispose() : void
      {
         if(this.params)
         {
            this.params.splice(0,this.params.length);
            this.params = null;
         }
         if(this.vehicles)
         {
            this.vehicles.splice(0,this.vehicles.length);
            this.vehicles = null;
         }
         if(this.classParams)
         {
            this.classParams.splice(0,this.classParams.length);
            this.classParams = null;
         }
         if(this.closeToRecord)
         {
            this.closeToRecord.splice(0,this.closeToRecord.length);
            this.closeToRecord = null;
         }
         if(this.rewardsLabels)
         {
            this.rewardsLabels.splice(0,this.rewardsLabels.length);
            this.rewardsLabels = null;
         }
         if(this.rewardsValues)
         {
            this.rewardsValues.splice(0,this.rewardsValues.length);
            this.rewardsValues = null;
         }
      }
      
      private function parsHash(param1:Object) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:Array = null;
         var _loc7_:String = null;
         var _loc8_:Number = NaN;
         var _loc9_:* = undefined;
         var _loc10_:Object = null;
         var _loc11_:String = null;
         var _loc12_:int = 0;
         var _loc13_:Boolean = false;
         var _loc14_:Array = null;
         var _loc15_:Array = null;
         var _loc16_:String = null;
         var _loc17_:String = null;
         this.aName = param1.hasOwnProperty("name") && param1["name"] != undefined ? param1["name"] : null;
         this.description = param1.hasOwnProperty("descr") && param1["descr"] != undefined ? Utils.instance.htmlWrapper(param1["descr"],Utils.instance.COLOR_NORMAL,12,"$TextFont") : null;
         this.condition = param1.hasOwnProperty("condition") && param1["condition"] != undefined && param1["condition"] != "" ? Utils.instance.htmlWrapper(param1["condition"],Utils.instance.COLOR_SUB_NORMAL,12,"$TextFont") : null;
         this.showCondSeparator = param1.hasOwnProperty("showCondSeparator") && param1["showCondSeparator"] != undefined ? Boolean(param1["showCondSeparator"]) : Boolean(false);
         this.inactive = param1.hasOwnProperty("inactive") && param1["inactive"] != undefined ? Boolean(param1["inactive"]) : Boolean(false);
         this.historyDescr = param1.hasOwnProperty("historyDescr") && param1["historyDescr"] != "" && param1["historyDescr"] != undefined ? param1["historyDescr"] : null;
         this.section = param1.hasOwnProperty("section") && param1["section"] != undefined ? param1["section"] : null;
         this.type = param1.hasOwnProperty("type") && param1["type"] != undefined ? param1["type"] : null;
         this.value = param1.hasOwnProperty("value") && param1["value"] != undefined ? Number(param1["value"]) : Number(NaN);
         this.localizedValue = param1.hasOwnProperty("localizedValue") && param1["localizedValue"] != undefined ? param1["localizedValue"] : Values.EMPTY_STR;
         this.icon = param1.hasOwnProperty("icon") && param1["icon"] != undefined ? param1["icon"] : null;
         this.isInDossier = param1.hasOwnProperty("isInDossier") && param1["isInDossier"] != undefined ? Boolean(param1["isInDossier"]) : Boolean(null);
         var _loc4_:Boolean = param1.hasOwnProperty("params") && param1["params"] != undefined ? Boolean(true) : Boolean(false);
         if(_loc4_)
         {
            if(param1["params"] is Array && param1["params"][0] is Array)
            {
               _loc6_ = param1["params"][0];
               this.params = [];
               _loc3_ = _loc6_.length;
               _loc7_ = "";
               _loc8_ = NaN;
               _loc2_ = 0;
               while(_loc2_ < _loc3_)
               {
                  _loc9_ = _loc6_[_loc2_];
                  _loc7_ = _loc9_[0];
                  if(_loc9_[1] is Array)
                  {
                     this.vehicles = _loc9_[1];
                     _loc8_ = _loc9_[2];
                     this.vehiclesLeft = _loc8_ - this.vehicles.length;
                     if(this.vehiclesLeft < 0)
                     {
                        this.vehiclesLeft = 0;
                     }
                  }
                  else
                  {
                     _loc8_ = _loc9_[1];
                  }
                  this.params.push({
                     "id":_loc7_,
                     "val":_loc8_
                  });
                  _loc2_++;
               }
            }
         }
         this.stats = param1.hasOwnProperty("stats") && param1["stats"] != undefined ? param1["stats"] : null;
         if(this.stats)
         {
            this.classParams = param1["stats"].hasOwnProperty("classParams") && param1["stats"]["classParams"] != undefined ? param1["stats"]["classParams"] : null;
         }
         if(param1.hasOwnProperty("records") && param1["records"] != undefined && param1["records"] != null)
         {
            _loc10_ = param1["records"];
            this.achievedOn = _loc10_.hasOwnProperty("current") && _loc10_["current"] != undefined && _loc10_["current"] != null ? _loc10_["current"] : null;
            this.closeToRecord = _loc10_.hasOwnProperty("nearest") && _loc10_["nearest"] != undefined && _loc10_["nearest"] != null && _loc10_["nearest"] is Array && _loc10_["nearest"].length > 0 ? _loc10_["nearest"] : null;
         }
         var _loc5_:Object = param1["crystalAwards"];
         if(_loc5_)
         {
            this.rewardsHeader = _loc5_["header"];
            this.hasReward = Boolean(this.rewardsHeader);
            if(this.hasReward)
            {
               this.rewardsHeader = Utils.instance.htmlWrapper(this.rewardsHeader,Utils.instance.COLOR_NORMAL,TEXT_FONT_SIZE,TEXT_FONT_NAME);
               _loc11_ = _loc5_["headerValue"];
               if(_loc11_)
               {
                  this.rewardsHeader += Utils.instance.htmlWrapper(_loc11_,Utils.instance.COLOR_CRYSTAL,TEXT_FONT_SIZE,TEXT_FONT_NAME);
               }
               else
               {
                  _loc12_ = _loc5_["selectedIndex"];
                  _loc13_ = false;
                  _loc14_ = _loc5_["labels"];
                  _loc15_ = _loc5_["values"];
                  this.rewardsLabels = [];
                  this.rewardsValues = [];
                  if(_loc12_ == Values.DEFAULT_INT)
                  {
                     _loc16_ = Utils.instance.COLOR_NORMAL_DARK;
                     _loc17_ = Utils.instance.COLOR_CRYSTAL;
                  }
                  else
                  {
                     _loc16_ = Utils.instance.COLOR_NORMAL_DARK;
                     _loc17_ = Utils.instance.COLOR_NORMAL_DARK;
                  }
                  if(_loc14_ && _loc15_ && _loc14_.length && _loc14_.length == _loc15_.length)
                  {
                     _loc3_ = _loc14_.length - 1;
                     _loc2_ = 0;
                     while(_loc2_ <= _loc3_)
                     {
                        _loc13_ = _loc12_ == _loc2_;
                        this.rewardsLabels.push(Utils.instance.htmlWrapper(_loc14_[_loc2_],!!_loc13_ ? Utils.instance.COLOR_NEUTRAL : _loc16_,TEXT_FONT_SIZE,TEXT_FONT_NAME) + BR);
                        this.rewardsValues.push(Utils.instance.htmlWrapper(_loc15_[_loc2_],!!_loc13_ ? Utils.instance.COLOR_CRYSTAL : _loc17_,TEXT_FONT_SIZE,TEXT_FONT_NAME) + BR);
                        _loc2_++;
                     }
                  }
               }
            }
         }
      }
   }
}
