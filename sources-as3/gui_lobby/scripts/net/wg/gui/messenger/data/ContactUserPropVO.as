package net.wg.gui.messenger.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.IUserProps;
   
   public class ContactUserPropVO extends DAAPIDataClass implements IUserProps
   {
      
      private static const ICONS_LBL:String = "icons";
      
      private static const TAGS_LBL:String = "tags";
       
      
      private var _fakeName:String = "";
      
      private var _userName:String = "";
      
      private var _clanAbbrev:String = "";
      
      private var _region:String = "";
      
      private var _igrType:int;
      
      private var _igrVspace:int = -4;
      
      private var _prefix:String = "";
      
      private var _suffix:String = "";
      
      private var _rgb:Number;
      
      private var _tags:Array;
      
      private var _icons:Vector.<String> = null;
      
      private var _isTeamKiller:Boolean = false;
      
      public function ContactUserPropVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         if(param1 == ICONS_LBL)
         {
            App.utils.asserter.assert(param2 is Array,param1 + " must be an Array");
            this._icons = new Vector.<String>();
            for each(_loc3_ in param2)
            {
               this._icons.push(_loc3_);
            }
            return false;
         }
         if(param1 == TAGS_LBL)
         {
            App.utils.asserter.assert(param2 is Array,param1 + " must be an Array");
            this._tags = [];
            for each(_loc4_ in param2)
            {
               this._tags.push(_loc4_);
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this._icons != null)
         {
            this._icons.splice(0,this._icons.length);
            this._icons = null;
         }
         this._tags.splice(0,this.tags.length);
         this._tags = null;
         super.onDispose();
      }
      
      public function get fakeName() : String
      {
         return this._fakeName;
      }
      
      public function set fakeName(param1:String) : void
      {
         this._fakeName = param1;
      }
      
      public function get userName() : String
      {
         return this._userName;
      }
      
      public function set userName(param1:String) : void
      {
         this._userName = param1;
      }
      
      public function get clanAbbrev() : String
      {
         return this._clanAbbrev;
      }
      
      public function set clanAbbrev(param1:String) : void
      {
         this._clanAbbrev = param1;
      }
      
      public function get region() : String
      {
         return this._region;
      }
      
      public function set region(param1:String) : void
      {
         this._region = param1;
      }
      
      public function get igrType() : int
      {
         return this._igrType;
      }
      
      public function set igrType(param1:int) : void
      {
         this._igrType = param1;
      }
      
      public function get prefix() : String
      {
         return this._prefix;
      }
      
      public function set prefix(param1:String) : void
      {
         this._prefix = param1;
      }
      
      public function get suffix() : String
      {
         return this._suffix;
      }
      
      public function set suffix(param1:String) : void
      {
         this._suffix = param1;
      }
      
      public function get igrVspace() : int
      {
         return this._igrVspace;
      }
      
      public function set igrVspace(param1:int) : void
      {
         this._igrVspace = param1;
      }
      
      public function get rgb() : Number
      {
         return this._rgb;
      }
      
      public function set rgb(param1:Number) : void
      {
         this._rgb = param1;
      }
      
      public function get tags() : Array
      {
         return this._tags;
      }
      
      public function set tags(param1:Array) : void
      {
         this._tags = param1;
      }
      
      public function get icons() : Vector.<String>
      {
         return this._icons;
      }
      
      public function get isTeamKiller() : Boolean
      {
         return this._isTeamKiller;
      }
      
      public function set isTeamKiller(param1:Boolean) : void
      {
         this._isTeamKiller = param1;
      }
      
      public function get isAnonymized() : Boolean
      {
         return this._fakeName && this._fakeName != this._userName;
      }
   }
}
