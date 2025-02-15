
import 'dart:convert';
// import "package:flutter_bloc/flutter_bloc.dart";

import 'package:hydrated_bloc/hydrated_bloc.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:equatable/equatable.dart';

// Note: some of this may be for BLoC instead of Cubit.
// Try taking out the 'get props' and/or copyWith.

class FDState  extends Equatable
{ 
  final String food;

  FDState(this.food);

  @override
  List<Object?> get props => [food];

  FDState copyWith({ String? food, }) 
    => FDState( food ?? this.food, );


  // turns the object into a map
  Map<String,dynamic> toMap()
  { return
    { 'food' : food ,
    };
  } 
  
  // turn a map back into an object
  factory FDState.fromMap(Map<String,dynamic> map)
  {
    return FDState( map['food'] );
  }

  // turns the object into JSON.  Does this by 
  // call toMap and then encode() ing the map.
  String toJson() => json.encode(toMap);

  // turns Json back into an objevct.  
  factory FDState.fromJson( String source) 
  => FDState.fromMap( json.decode(source));
   
}

class FDCubit extends HydratedCubit<FDState> // with HydratedMixin
{
  FDCubit() : super( FDState("banana") );

  void setFood(String f ) { emit( FDState(f) ); }

  // converts the map form of FDState into an object.
  // should have been called fromMap, as the Hydrated stuff
  // will have already converted it from JSON to a map.
  @override
  FDState fromJson( Map<String,dynamic> map)
  { return FDState.fromMap(map); }

  // This is called on s AFTER emit(s).  Every time there is a new
  // state, this function converts it to a Map and the Hydrated
  // stuff takes it from there.  
  @override
  Map<String,dynamic> toJson( FDState state )
  { return state.toMap(); }
}