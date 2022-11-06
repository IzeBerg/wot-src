package net.wg.gui.battle.views.stats
{
   import net.wg.infrastructure.interfaces.IUserProps;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class StatsUserProps implements IUserProps, IDisposable
   {
       
      
      private var _fakeName:String = null;
      
      private var _userName:String = null;
      
      private var _clanAbbrev:String = null;
      
      private var _region:String = null;
      
      private var _igrType:int = 0;
      
      private var _prefix:String = null;
      
      private var _suffix:String = null;
      
      private var _igrVspace:int = -4;
      
      private var _rgb:Number = NaN;
      
      private var _tags:Array = null;
      
      private var _isChanged:Boolean = false;
      
      private var _isTeamKiller:Boolean = false;
      
      private var _disposed:Boolean = false;
      
      public function StatsUserProps(param1:String, param2:String, param3:String, param4:String, param5:int, param6:Array = null)
      {
         super();
         this._fakeName = param2;
         this._userName = param1;
         this._clanAbbrev = param3;
         this._region = param4;
         this._igrType = param5;
         this._tags = param6;
         this._isChanged = true;
      }
      
      public function applyChanges() : void
      {
         this._isChanged = false;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.onDispose();
      }
      
      protected function onDispose() : void
      {
         if(this._tags)
         {
            this._tags.length = 0;
            this._tags = null;
         }
      }
      
      private function compareArrays(param1:Array, param2:Array) : Boolean
      {
         if(param1 == param2)
         {
            return true;
         }
         if(!param1 || !param2)
         {
            return false;
         }
         var _loc3_:int = param1.length;
         if(_loc3_ != param2.length)
         {
            return false;
         }
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if(param1[_loc4_] != param2[_loc4_])
            {
               return false;
            }
            _loc4_++;
         }
         return true;
      }
      
      public function get fakeName() : String
      {
         return this._fakeName;
      }
      
      public function set fakeName(param1:String) : void
      {
         if(this._fakeName == param1)
         {
            return;
         }
         this._fakeName = param1;
         this._isChanged = true;
      }
      
      public function get userName() : String
      {
         return this._userName;
      }
      
      public function set userName(param1:String) : void
      {
         if(this._userName == param1)
         {
            return;
         }
         this._userName = param1;
         this._isChanged = true;
      }
      
      public function get clanAbbrev() : String
      {
         return this._clanAbbrev;
      }
      
      public function set clanAbbrev(param1:String) : void
      {
         if(this._clanAbbrev == param1)
         {
            return;
         }
         this._clanAbbrev = param1;
         this._isChanged = true;
      }
      
      public function get region() : String
      {
         return this._region;
      }
      
      public function set region(param1:String) : void
      {
         if(this._region == param1)
         {
            return;
         }
         this._region = param1;
         this._isChanged = true;
      }
      
      public function get igrType() : int
      {
         return this._igrType;
      }
      
      public function set igrType(param1:int) : void
      {
         if(this._igrType == param1)
         {
            return;
         }
         this._igrType = param1;
         this._isChanged = true;
      }
      
      public function get prefix() : String
      {
         return this._prefix;
      }
      
      public function set prefix(param1:String) : void
      {
         if(this._prefix == param1)
         {
            return;
         }
         this._prefix = param1;
         this._isChanged = true;
      }
      
      public function get suffix() : String
      {
         return this._suffix;
      }
      
      public function set suffix(param1:String) : void
      {
         if(this._suffix == param1)
         {
            return;
         }
         this._suffix = param1;
         this._isChanged = true;
      }
      
      public function get igrVspace() : int
      {
         return this._igrVspace;
      }
      
      public function set igrVspace(param1:int) : void
      {
         if(this._igrVspace == param1)
         {
            return;
         }
         this._igrVspace = param1;
         this._isChanged = true;
      }
      
      public function get rgb() : Number
      {
         return this._rgb;
      }
      
      public function set rgb(param1:Number) : void
      {
         if(this._rgb == param1)
         {
            return;
         }
         this._rgb = param1;
         this._isChanged = true;
      }
      
      public function get tags() : Array
      {
         return this._tags;
      }
      
      public function set tags(param1:Array) : void
      {
         if(this.compareArrays(this._tags,param1))
         {
            return;
         }
         this._tags = param1;
         this._isChanged = true;
      }
      
      public function get isChanged() : Boolean
      {
         return this._isChanged;
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
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
